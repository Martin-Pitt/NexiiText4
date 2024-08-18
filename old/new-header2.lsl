#define TEXTURE_INTER "0af77e72-3f71-563e-e80a-cea71b5308a7"
#define TEXTURE_EIGHT "876a12ca-928e-baf1-a35b-f3aab5db95bc"
#define TEXTURE_SIZE 2048.
#define CELL_SIZE 64.
#define GAP_WIDTH 120.66666666666666
#define MAX_PARAMS 100

// Uncomment to enable font weights based on alpha masking, however alpha masking is not aliased and may appear glitchy 
// #define VARIABLE_FONT_WEIGHTS


// Resources
list Free;
list Used;

// Settings
vector Color = <1,1,1>;
#ifdef VARIABLE_FONT_WEIGHTS
integer FontWeight = 400; 
#endif
float FontSize = 0.64;
float LineHeight = 1.2;
// string FontFamily = "Inter";
// string TextWrap = "wrap"; // "nowrap"
float TextWrapLength = 64.0;
// string TextOverflow = "clip"; // "ellipsis"
// integer TextShadow = FALSE;
// vector TextShadowColor = <0,0,0>;
// vector TextShadowWeight = 700;
// float TextShadowOffsetX = 0.05;
// float TextShadowOffsetY = 0.05;
float TabWidth = 4;

/*
    Newlines can be created because of:
    1. Letter is a newline character
    2. TextWrap setting
    3. Font column width
    
    Splits happen because:
    1. Out of available faces on the mesh
    2. Not enough room in font texture column
    
    Wraps happen because:
    1. Trying to start drawing glyphs out of bounds (after whitespace pushed it there)
    2. Word collides with wrap length boundary, reverse until whitespace and redo onto newline
        - Words are broken up if there is no previous whitespace
    
    TODO: Word breaks only happen on whitespaces, 
*/


// Positional -- all in px sizes
vector Anchor = <0,0,0>;
rotation Direction = <0,0,0,1>;
vector Cursor; // = <0, FontSize * LineHeight * -0.5, 0>;
float lastSplitPos;
float lastPrintPos;
float lastSpacePos;

// Indexes -- string character indexes
integer lastPrintStart;
integer lastPrintIndex;

// Misc
integer facesLeft = 8;
list glyphs = [/* rotation[] glyph = <centerOfGlyph.xy, glyphWidth, glyphPrintablePosX> */];
list printables = [/* x, y, width, linkTarget, glyphsStart, glyphsTotal, txtStart */];
list printableGlyphs = [/* rotation[] glyph = <centerOfGlyph.xy, glyphWidth, glyphPrintablePosX> */];
integer isNewline = FALSE;
integer isWrapping = FALSE;
string TAB; // Set with real tab character on textInit()

text(string txt)
{
    // llOwnerSay("text("" + txt + "")");
    if(!llGetListLength(Free)) return llOwnerSay("Out of prims to render with [#1]");
    
    // Constants
    float wrapLength = TextWrapLength / FontSize * CELL_SIZE;
    float tabWidth = 12.5 * TabWidth; // / FontSize * CELL_SIZE;
    
    // Positional
    float width;
    lastSpacePos = 0.0; // Can only use this if the txt had the whitespace character
    
    // Indexes
    lastPrintStart = 0;
    integer lastSpaceIndex;
    
    // Loop
    integer index; integer txtLength = llStringLength(txt);
    for(; index < txtLength; ++index)
    {
        string letter = llGetSubString(txt, index, index);
        
        // llOwnerSay("Consuming " + (string)index + " "" + letter + """);
        
        // Handling spacing characters
        if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 12.5; } // Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 25; } // EN Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 50; } // EM Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 16.69921875; } // Three-per-EM Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 12.5; } // Four-per-EM Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 8.30078125; } // Six-per-EM Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 32.2265625; } // Figure Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 10.986328125; } // Punctuation Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 7.51953125; } // Thin Space
        else if(letter == " ") { lastSpaceIndex = index; lastSpacePos = Cursor.x += 2.978515625; } // Hair Space
        else if(letter == TAB) { // Tab indentation
            lastSpaceIndex = index;
            float indent = llCeil(Cursor.x / tabWidth) * tabWidth;
            if(indent - Cursor.x < 12.5) indent += tabWidth;
            lastSpacePos = Cursor.x = indent;
        }
        else if(letter == "\n") isNewline++; // Newline
        
        else
        {
            // Printable characters
            vector g = Glyphs(letter);
            if(g != ZERO_VECTOR)
            {
                rotation glyph = <g.x, g.y, g.z, 0 /* position in a printable */>;
                width = Cursor.x - lastSplitPos;
                integer needsSplit = (width + glyph.z >= GAP_WIDTH);
                
                // if(TextWrap == "wrap" && (width + glyph.z > wrapLength)) isNewline = TRUE;
                if(Cursor.x + glyph.z > wrapLength) isWrapping = TRUE;
                // if(isWrapping && lastSpacePos == 0.0) needsSplit = TRUE; // Forced word break
                
                if(!facesLeft || needsSplit || isWrapping || isNewline)
                {
                    // Flush glyphs to printable
                    if(glyphs)
                    {
                        integer printEnd = index - 1;
                        
                        // list reason;
                        // if(!facesLeft) reason += "no faces";
                        // if(needsSplit) reason += "needs split";
                        // if(isWrapping) reason += "wrapping";
                        // if(isNewline) reason += "newline";
                        // llOwnerSay("Flushing printable (" + llList2CSV(reason) + ") " + (string)lastPrintStart + ":" + (string)printEnd + " "" + llGetSubString(txt, lastPrintStart, printEnd) + """);
                        
                        if(llGetListLength(Free))
                        {
                            integer linkTarget = llList2Integer(Free, 0);
                            Free = llDeleteSubList(Free, 0, 0);
                            Used += linkTarget;
                            
                            printables += [
                                lastSplitPos,
                                Cursor.y,
                                lastPrintPos - lastSplitPos,
                                linkTarget,
                                llGetListLength(printableGlyphs),
                                llGetListLength(glyphs),
                                lastPrintStart
                            ];
                            printableGlyphs += glyphs;
                        }
                        
                        else llOwnerSay("Out of prims to render with [#3]");
                        
                        glyphs = [];
                        lastPrintStart = index;
                    }
                    
                    // Did we wrap? Also if we were only whitespace, just drop down
                    if(isWrapping && lastSpaceIndex && lastSpacePos > wrapLength)
                    {
                        // llOwnerSay("isWrapping (whitespace)");
                        // llOwnerSay("isWrapping (whitespace)\n"
                        //     + "lastSpacePos: " + (string)lastSpacePos + "\n"
                        //     + "Cursor.x: " + (string)Cursor.x + "\n"
                        //     + llGetSubString(txt, index - 4, index - 1) + "|" + llGetSubString(txt, index, index + 6)
                        // );
                        
                        // Undoing glyphs on current
                        while(Cursor.x > lastSpacePos)
                        {
                            Cursor.x -= glyph.z;
                            lastPrintPos = Cursor.x;
                            glyph = llList2Rot(glyphs, -1);
                            glyphs = llDeleteSubList(glyphs, -1, -1);
                        }
                        
                        Cursor.x = lastSpacePos;
                        index = lastSpaceIndex;
                    }
                    
                    // Did we wrap? And was there a whitespace on this line?
                    else if(isWrapping && lastSpaceIndex)
                    {
                        // llOwnerSay("isWrapping (word-wrap)");
                        // llOwnerSay("isWrapping (word-wrap)\n"
                        //     + "lastSpacePos: " + (string)lastSpacePos + ",  Cursor.x: " + (string)Cursor.x + "\n"
                        //     + llGetSubString(txt, lastPrintStart - 6, lastPrintStart) + "|   |" + llGetSubString(txt, index, index + 6)
                        // );
                        
                        // Undo printables
                        width = 0;
                        facesLeft = 8;
                        glyphs = [];
                        index = lastPrintStart - 1;
                        
                        while(index > lastSpaceIndex)
                        {
                            list printable = llList2List(printables, -7, -1);
                            float x = llList2Float(printable, 0);
                            float y = llList2Float(printable, 1);
                            float width = llList2Float(printable, 2);
                            integer linkTarget = llList2Integer(printable, 3);
                            integer glyphsStart = llList2Integer(printable, 4);
                            integer glyphsTotal = llList2Integer(printable, 5);
                            integer txtStart = llList2Integer(printable, 6);
                            
                            // llOwnerSay("Checking printable " + llList2CSV(printable));
                            
                            
                            // If we are still not at the printable with the whitespace, drop the printable
                            if(lastSpaceIndex < txtStart)
                            {
                                // llOwnerSay("Dropping printable of " + (string)txtStart + ":" + (string)index + " "" + llGetSubString(txt, txtStart, index) + ""\n" + llList2CSV(printable));
                                
                                printableGlyphs = llDeleteSubList(printableGlyphs, -glyphsTotal, -1);
                                printables = llDeleteSubList(printables, -7, -1);
                                Used = llDeleteSubList(Used, -1, -1);
                                Free += linkTarget;
                                
                                Cursor.x = x;
                                index = txtStart - 1;
                            }
                            
                            
                            // At the correct printable now but some glyphs to drop
                            else if(txtStart < lastSpaceIndex)
                            {
                                // llOwnerSay("Dropping glyphs in " + (string)txtStart + ":" + (string)index + " "" + llGetSubString(txt, txtStart, index) + """);
                                // llOwnerSay("- width: " + (string)width);
                                
                                list positions;
                                list glyphs = llList2List(printableGlyphs, glyphsStart, glyphsStart + glyphsTotal - 1);
                                integer iterator;
                                for(; iterator < glyphsTotal; ++iterator)
                                {
                                    glyph = llList2Rot(printableGlyphs, glyphsStart + iterator);
                                    positions += glyph.s; // glyphPrintablePosX
                                }
                                
                                // llOwnerSay("- glyphs: " + llList2CSV(positions));
                                
                                // Printable was split at the left beginning, Cursor.x moved to end of printable
                                lastSplitPos = x;
                                Cursor.x = x + width;
                                
                                // Lets see what we need to drop
                                integer dropped = 0;
                                while(lastSpacePos < Cursor.x)
                                {
                                    dropped++;
                                    glyph = llList2Rot(printableGlyphs, glyphsStart + glyphsTotal - dropped);
                                    Cursor.x = x + glyph.s; // glyphPrintablePosX
                                }
                                
                                if(dropped)
                                {
                                    // Remove glyphs
                                    printableGlyphs = llDeleteSubList(printableGlyphs, -dropped, -1);
                                    glyphsTotal -= dropped;
                                    // llOwnerSay("-- Dropped " + (string)dropped + " glyphs");
                                    
                                    // Set Cursor to end of last glyph
                                    glyph = llList2Rot(printableGlyphs, glyphsStart + glyphsTotal - 1);
                                    Cursor.x = x + glyph.z + glyph.s; // printablePos.x + glyphWidth + glyphPrintablePosX
                                    
                                    width = Cursor.x - lastSplitPos;
                                    // llOwnerSay("- width set to " + (string)width);
                                    
                                    printable = llListReplaceList(printable, [width], 2, 2);
                                    printable = llListReplaceList(printable, [glyphsTotal], 5, 5);
                                    printables = llListReplaceList(printables, printable, -7, -1);
                                }
                                
                                index = lastSpaceIndex;
                            }
                        }
                        
                        glyph = llList2Rot(printableGlyphs, -1);
                        
                        Cursor.x = lastSpacePos;
                        index = lastSpaceIndex;
                    }
                    
                    else if(isWrapping)
                    {
                        // llOwnerSay("isWrapping (no space)");
                    }
                    
                    // Mark split boundary
                    if(!facesLeft || needsSplit)
                    {
                        lastSplitPos = Cursor.x;
                    }
                    
                    // Reset onto new line
                    if(isWrapping || isNewline)
                    {
                        lastSplitPos = 0.0;
                        lastPrintPos = 0.0;
                        lastSpacePos = 0.0;
                        Cursor.x = 0.0;
                        if(isNewline) Cursor.y -= FontSize * LineHeight * isNewline;
                        else Cursor.y -= FontSize * LineHeight;
                        lastSpaceIndex = FALSE;
                    }
                    
                    width = 0;
                    facesLeft = 8;
                    glyphs = [];
                }
                
                // If not wrapping, add glyph as we normally do
                if(!isWrapping)
                {
                    glyphs += <glyph.x - glyph.z/2, glyph.y, glyph.z, width>; // <centerOfGlyph.x, *.y, glyphWidth, glyphPrintablePosX> 
                    Cursor.x += glyph.z; // glyphWidth
                    lastPrintPos = Cursor.x;
                    facesLeft--;
                }
                
                needsSplit = isWrapping = isNewline = FALSE;
                lastPrintIndex = index;
            }
        }
    }
    
    // TODO: Now that we are always flushing to printables. We could instead check the last printable in future text("…") calls to see if we can keep drawing glyphs on it if there is room (faces left + no split)
    
    // Flush glyphs to printable
    if(glyphs)
    {
        integer printEnd = index - 1;
        
        // llOwnerSay("Flushing printable (end) " + (string)lastPrintStart + ":" + (string)printEnd + " "" + llGetSubString(txt, lastPrintStart, printEnd) + """);
        
        if(llGetListLength(Free))
        {
            integer linkTarget = llList2Integer(Free, 0);
            Free = llDeleteSubList(Free, 0, 0);
            Used += linkTarget;
            
            printables += [
                lastSplitPos,
                Cursor.y,
                lastPrintPos - lastSplitPos,
                linkTarget,
                llGetListLength(printableGlyphs),
                llGetListLength(glyphs),
                lastPrintStart
            ];
            printableGlyphs += glyphs;
        }
        
        else llOwnerSay("Out of prims to render with [#2]");
        
        glyphs = [];
        lastPrintStart = index;
    }
}

textStyle()
{
    // llOwnerSay("textStyle()");
    
    // Render printables into prim params for applying styling
    if(printables)
    {
        #ifdef VARIABLE_FONT_WEIGHTS
        integer cutoff = llRound(220. + ((64. - 220.) * ((100. - FontWeight) / (100. - 900.))));
        #endif
        list params = [];
        integer pointer = 0; integer max = llGetListLength(printables);
        for(; pointer < max;)
        {
            integer linkTarget = llList2Integer(printables, pointer + 3);
            integer start = llList2Integer(printables, pointer + 4);
            integer total = llList2Integer(printables, pointer + 5);
            pointer += 7;
            
            params += [PRIM_LINK_TARGET, linkTarget];
            
            integer index;
            for(index = 0; index < total; ++index)
            {
                integer face = 7 - index;
                // rotation glyph = llList2Rot(glyphs, index);
                params += [
                    PRIM_COLOR, face, Color, 1
                    
                    #ifdef VARIABLE_FONT_WEIGHTS
                    , PRIM_ALPHA_MODE, face, PRIM_ALPHA_MODE_MASK, cutoff
                    #endif
                ];
            }
            
            if(llGetListLength(params) > MAX_PARAMS)
            {
                llSetLinkPrimitiveParamsFast(0, params);
                params = [];
            }
        }
        
        if(params)
        {
            llSetLinkPrimitiveParamsFast(0, params);
            params = [];
        }
    }
}

textFlush()
{
    // llOwnerSay("textFlush()");
    
    float minWidth = .01 / FontSize * CELL_SIZE; // Smallest prim size possible
    
    // Render printables into prim params for glyph texture coordinates, locations and sizes
    if(printables)
    {
        list params = [];
        while(printables)
        {
            float x = llList2Float(printables, 0);
            float y = llList2Float(printables, 1);
            float width = llList2Float(printables, 2);
            integer linkTarget = llList2Integer(printables, 3);
            integer total = llList2Integer(printables, 5);
            list glyphs = llList2List(printableGlyphs, 0, total - 1);
            printables = llDeleteSubList(printables, 0, 6);
            printableGlyphs = llDeleteSubList(printableGlyphs, 0, total - 1);
            if(width < minWidth) width = minWidth;
            
            params += [PRIM_LINK_TARGET, linkTarget];
            
            vector repeats = <width / TEXTURE_SIZE, CELL_SIZE / TEXTURE_SIZE, 0>;
            integer index;
            for(index = 0; index < total; ++index)
            {
                integer face = 7 - index;
                rotation glyph = llList2Rot(glyphs, index);
                vector offsets = <(glyph.x - glyph.s + width / 2) / TEXTURE_SIZE, glyph.y / -TEXTURE_SIZE, 0>;
                params += [PRIM_TEXTURE, face, TEXTURE_INTER, repeats, offsets, 0];
            }
            
            x += width / 2;
            x = x / CELL_SIZE * FontSize;
            
            params += [
                PRIM_POS_LOCAL, Anchor + <0, x, y> * Direction,
                PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
                PRIM_SIZE, <width / CELL_SIZE * FontSize, FontSize, 0.01>
            ];
            
            if(llGetListLength(params) > MAX_PARAMS)
            {
                llSetLinkPrimitiveParamsFast(0, params);
                params = [];
            }
        }
        
        if(params)
        {
            llSetLinkPrimitiveParamsFast(0, params);
            params = [];
        }
    }
    
    lastSplitPos = 0.0;
    lastPrintPos = 0.0;
    lastSpacePos = 0.0;
    facesLeft = 8;
    glyphs = [];
    printables = [];
    printableGlyphs = [];
    isWrapping = FALSE;
    isNewline = FALSE;
}

// Initializes the system by checking for Text prims and resetting them
textInit()
{
    TAB = llChar(9);
    Free = [];
    Used = [];
    
    // Identify all the Text prims and move them out of the way for now
    list params;
    integer Prims = llGetNumberOfPrims() + 1;
    while(--Prims)
    {
        if(llGetLinkName(Prims) == "Text")
        {
            Free += Prims;
            
            params += [
                PRIM_LINK_TARGET, Prims,
                PRIM_POS_LOCAL, <0,0,0>,
                PRIM_SIZE, <.01,.01,.01>
            ];
            
            if(llGetListLength(params) > MAX_PARAMS)
            {
                llSetLinkPrimitiveParamsFast(0, params);
                params = [];
            }
        }
    }
    
    if(params)
    {
        llSetLinkPrimitiveParamsFast(0, params);
        params = [];
    }
    
    // Second pass where we give them the default properties
    #ifdef VARIABLE_FONT_WEIGHTS
    integer cutoff = llRound(220. + ((64. - 220.) * ((100. - FontWeight) / (100. - 900.))));
    #endif
    
    Prims = llGetListLength(Free);
    while(Prims --> 0)
    {
        params += [
            PRIM_LINK_TARGET, llList2Integer(Free, Prims),
            PRIM_ROT_LOCAL, <.5,.5,.5,.5>,
            PRIM_COLOR, ALL_SIDES, Color, 1,
            PRIM_TEXTURE, ALL_SIDES, TEXTURE_INTER, ZERO_VECTOR, ZERO_VECTOR, 0.0,
            #ifdef VARIABLE_FONT_WEIGHTS
            PRIM_ALPHA_MODE, ALL_SIDES, PRIM_ALPHA_MODE_MASK, cutoff
            #else
            PRIM_ALPHA_MODE, ALL_SIDES, PRIM_ALPHA_MODE_BLEND, 0
            #endif
        ];
        
        if(llGetListLength(params) > MAX_PARAMS)
        {
            llSetLinkPrimitiveParamsFast(0, params);
            params = [];
        }
    }
    
    if(params) llSetLinkPrimitiveParamsFast(0, params);
    
    
    // llOwnerSay("------------------------ NexText4 Init ------------------------\n"
    //     + "Prims: " + (string)llGetListLength(Free) + "\n"
    //     + "Free Memory: " + (string)llRound(llGetFreeMemory() / 1024) + "KB"
    // );
}

// Function to check if a string can be rendered or not, e.g. a display name
integer textCanBeRendered(string text)
{
    integer count = llStringLength(text);
    while(count --> 0)
    {
        string letter = llGetSubString(text, count, count);
        if(letter == " "); // Space
        else if(letter == " "); // EN Space
        else if(letter == " "); // EM Space
        else if(letter == " "); // Three-per-EM Space
        else if(letter == " "); // Four-per-EM Space
        else if(letter == " "); // Six-per-EM Space
        else if(letter == " "); // Figure Space
        else if(letter == " "); // Punctuation Space
        else if(letter == " "); // Thin Space
        else if(letter == " "); // Hair Space
        else if(letter == "\n"); // Newline
        else if(Glyphs(letter) == ZERO_VECTOR) return FALSE;
    }
    return TRUE;
}


// Render data into a table Layout
#define TABLE_LAYOUT 1
#define TABLE_LAYOUT_AUTO 1
#define TABLE_LAYOUT_FIXED 2
#define TABLE_WIDTH 2
#define TABLE_PADDING 3

textTable(list data, integer stride, list settings)
{
    // Constants
    float METERS_TO_PIXELS = CELL_SIZE / FontSize;
    float PIXELS_TO_METERS = FontSize / CELL_SIZE;
    
    // Parse parameters
    integer tableLayout = TABLE_LAYOUT_AUTO;
    float tableWidth = 100.0;
    float cellPadding = 10.0;
    
    integer index; integer total;
    for(index = 0, total = llGetListLength(settings); ++index)
    {
        integer parameter = llList2Integer(settings, index);
        if(parameter == TABLE_LAYOUT) tableLayout = llList2Integer(settings, ++index);
        else if(parameter == TABLE_WIDTH) tableWidth = llList2Float(settings, ++index) * METERS_TO_PIXELS;
        else if(parameter == TABLE_PADDING) cellPadding = llList2Float(settings, ++index) * METERS_TO_PIXELS;
    }
    
    // Draw auto layout
    if(tableLayout == TABLE_LAYOUT_AUTO)
    {
        integer index; integer total;
        for(index = 0, total = llGetListLength(data); index += stride)
        {
            // cursor.x = 
            
            // integer row = ;
            // integer column = ;
            
            
            
        }
    }
}


// Texture coordinates and letter spacing
vector Glyphs(string Glyph) {
	if(Glyph == "0") return <-923.33, -992, 30.66>; if(Glyph == "1") return <-929.61, -928, 18.12>; if(Glyph == "2") return <-924.64, -864, 28.05>;
	if(Glyph == "3") return <-923.70, -800, 29.93>; if(Glyph == "4") return <-923.22, -736, 30.88>; if(Glyph == "5") return <-924.25, -672, 28.83>;
	if(Glyph == "6") return <-924.07, -608, 29.20>; if(Glyph == "7") return <-925.78, -544, 25.78>; if(Glyph == "8") return <-924.12, -480, 29.10>;
	if(Glyph == "9") return <-924.07, -416, 29.20>; if(Glyph == "a") return <-925.73, -352, 25.88>; if(Glyph == "b") return <-924.53, -288, 28.27>;
	if(Glyph == "c") return <-925.59, -224, 26.15>; if(Glyph == "d") return <-924.53, -160, 28.27>; if(Glyph == "e") return <-925.26, -96, 26.81>;
	if(Glyph == "f") return <-931.01, -32, 15.31>; if(Glyph == "g") return <-924.53, 32, 28.27>; if(Glyph == "h") return <-924.99, 96, 27.34>;
	if(Glyph == "i") return <-933.52, 160, 10.30>; if(Glyph == "j") return <-933.52, 224, 10.30>; if(Glyph == "k") return <-925.98, 288, 25.37>;
	if(Glyph == "l") return <-933.52, 352, 10.30>; if(Glyph == "m") return <-917.69, 416, 41.94>; if(Glyph == "n") return <-924.99, 480, 27.34>;
	if(Glyph == "o") return <-924.95, 544, 27.44>; if(Glyph == "p") return <-924.53, 608, 28.27>; if(Glyph == "q") return <-924.53, 672, 28.27>;
	if(Glyph == "r") return <-930.61, 736, 16.11>; if(Glyph == "s") return <-926.80, 800, 23.73>; if(Glyph == "t") return <-930.89, 864, 15.55>;
	if(Glyph == "u") return <-924.99, 928, 27.34>; if(Glyph == "v") return <-925.87, 992, 25.59>; if(Glyph == "w") return <-749.20, -992, 37.60>;
	if(Glyph == "x") return <-755.33, -928, 25.34>; if(Glyph == "y") return <-755.21, -864, 25.59>; if(Glyph == "z") return <-756.04, -800, 23.93>;
	if(Glyph == "A") return <-751.67, -736, 32.67>; if(Glyph == "B") return <-752.05, -672, 31.91>; if(Glyph == "C") return <-749.95, -608, 36.11>;
	if(Glyph == "D") return <-750.76, -544, 34.47>; if(Glyph == "E") return <-753.51, -480, 28.98>; if(Glyph == "F") return <-754.15, -416, 27.71>;
	if(Glyph == "G") return <-749.74, -352, 36.52>; if(Glyph == "H") return <-750.30, -288, 35.40>; if(Glyph == "I") return <-762.19, -224, 11.62>;
	if(Glyph == "J") return <-754.63, -160, 26.73>; if(Glyph == "K") return <-752.14, -96, 31.71>; if(Glyph == "L") return <-754.62, -32, 26.76>;
	if(Glyph == "M") return <-746.56, 32, 42.87>; if(Glyph == "N") return <-750.25, 96, 35.50>; if(Glyph == "O") return <-749.27, 160, 37.45>;
	if(Glyph == "P") return <-752.70, 224, 30.59>; if(Glyph == "Q") return <-749.27, 288, 37.45>; if(Glyph == "R") return <-752.19, 352, 31.62>;
	if(Glyph == "S") return <-752.64, 416, 30.71>; if(Glyph == "T") return <-752.74, 480, 30.52>; if(Glyph == "U") return <-750.42, 544, 35.16>;
	if(Glyph == "V") return <-751.67, 608, 32.67>; if(Glyph == "W") return <-744.27, 672, 47.46>; if(Glyph == "X") return <-751.86, 736, 32.28>;
	if(Glyph == "Y") return <-751.94, 800, 32.13>; if(Glyph == "Z") return <-752.67, 864, 30.66>; if(Glyph == "!") return <-762.51, 928, 10.99>;
	if(Glyph == "\"") return <-757.92, 992, 20.17>; if(Glyph == "#") return <-582.34, -992, 29.98>; if(Glyph == "$") return <-581.98, -928, 30.71>;
	if(Glyph == "%") return <-576.24, -864, 42.19>; if(Glyph == "&") return <-582.12, -800, 30.42>; if(Glyph == "'") return <-590.99, -736, 12.70>;
	if(Glyph == "(") return <-589.86, -672, 14.94>; if(Glyph == ")") return <-589.86, -608, 14.94>; if(Glyph == "*") return <-585.61, -544, 23.44>;
	if(Glyph == "+") return <-581.64, -480, 31.40>; if(Glyph == ",") return <-591.84, -416, 10.99>; if(Glyph == "-") return <-586.62, -352, 21.44>;
	if(Glyph == ".") return <-591.84, -288, 10.99>; if(Glyph == "/") return <-589.20, -224, 16.26>; if(Glyph == ":") return <-591.84, -160, 10.99>;
	if(Glyph == ";") return <-591.77, -96, 11.13>; if(Glyph == "<") return <-581.64, -32, 31.40>; if(Glyph == "=") return <-581.64, 32, 31.40>;
	if(Glyph == ">") return <-581.64, 96, 31.40>; if(Glyph == "?") return <-584.24, 160, 26.20>; if(Glyph == "@") return <-572.99, 224, 48.68>;
	if(Glyph == "[") return <-589.86, 288, 14.94>; if(Glyph == "\\") return <-589.20, 352, 16.26>; if(Glyph == "]") return <-589.86, 416, 14.94>;
	if(Glyph == "^") return <-586.40, 480, 21.88>; if(Glyph == "_") return <-585.98, 544, 22.71>; if(Glyph == "{") return <-587.71, 608, 19.24>;
	if(Glyph == "|") return <-589.94, 672, 14.79>; if(Glyph == "}") return <-587.71, 736, 19.24>; if(Glyph == "~") return <-581.64, 800, 31.40>;
	if(Glyph == "¡") return <-591.69, 864, 11.28>; if(Glyph == "¢") return <-584.26, 928, 26.15>; if(Glyph == "£") return <-582.78, 992, 29.10>;
	if(Glyph == "¤") return <-409.38, -992, 34.57>; if(Glyph == "¥") return <-413.75, -928, 25.83>; if(Glyph == "¦") return <-420.81, -864, 11.72>;
	if(Glyph == "§") return <-413.24, -800, 26.86>; if(Glyph == "¨") return <-412.99, -736, 27.34>; if(Glyph == "©") return <-404.60, -672, 44.14>;
	if(Glyph == "ª") return <-416.12, -608, 21.09>; if(Glyph == "«") return <-413.59, -544, 26.15>; if(Glyph == "¬") return <-410.97, -480, 31.40>;
	if(Glyph == "®") return <-410.90, -416, 31.54>; if(Glyph == "°") return <-416.10, -352, 21.14>; if(Glyph == "±") return <-410.97, -288, 31.40>;
	if(Glyph == "²") return <-417.04, -224, 19.26>; if(Glyph == "³") return <-416.63, -160, 20.07>; if(Glyph == "´") return <-420.64, -96, 12.06>;
	if(Glyph == "µ") return <-412.85, -32, 27.64>; if(Glyph == "¶") return <-412.62, 32, 28.10>; if(Glyph == "·") return <-421.17, 96, 10.99>;
	if(Glyph == "¹") return <-420.15, 160, 13.04>; if(Glyph == "º") return <-415.52, 224, 22.29>; if(Glyph == "»") return <-413.59, 288, 26.15>;
	if(Glyph == "¼") return <-408.58, 352, 36.18>; if(Glyph == "½") return <-407.77, 416, 37.79>; if(Glyph == "¾") return <-406.56, 480, 40.21>;
	if(Glyph == "¿") return <-413.57, 544, 26.20>; if(Glyph == "À") return <-410.33, 608, 32.67>; if(Glyph == "Á") return <-410.33, 672, 32.67>;
	if(Glyph == "Â") return <-410.33, 736, 32.67>; if(Glyph == "Ã") return <-410.33, 800, 32.67>; if(Glyph == "Ä") return <-410.33, 864, 32.67>;
	if(Glyph == "Å") return <-410.33, 928, 32.67>; if(Glyph == "Æ") return <-402.48, 992, 48.36>; if(Glyph == "Ç") return <-237.95, -992, 36.11>;
	if(Glyph == "È") return <-241.51, -928, 28.98>; if(Glyph == "É") return <-241.51, -864, 28.98>; if(Glyph == "Ê") return <-241.51, -800, 28.98>;
	if(Glyph == "Ë") return <-241.51, -736, 28.98>; if(Glyph == "Ì") return <-250.19, -672, 11.62>; if(Glyph == "Í") return <-250.19, -608, 11.62>;
	if(Glyph == "Î") return <-250.19, -544, 11.62>; if(Glyph == "Ï") return <-250.19, -480, 11.62>; if(Glyph == "Ð") return <-237.92, -416, 36.16>;
	if(Glyph == "Ñ") return <-238.25, -352, 35.50>; if(Glyph == "Ò") return <-237.27, -288, 37.45>; if(Glyph == "Ó") return <-237.27, -224, 37.45>;
	if(Glyph == "Ô") return <-237.27, -160, 37.45>; if(Glyph == "Õ") return <-237.27, -96, 37.45>; if(Glyph == "Ö") return <-237.27, -32, 37.45>;
	if(Glyph == "×") return <-240.30, 32, 31.40>; if(Glyph == "Ø") return <-237.27, 96, 37.45>; if(Glyph == "Ù") return <-238.42, 160, 35.16>;
	if(Glyph == "Ú") return <-238.42, 224, 35.16>; if(Glyph == "Û") return <-238.42, 288, 35.16>; if(Glyph == "Ü") return <-238.42, 352, 35.16>;
	if(Glyph == "Ý") return <-239.94, 416, 32.13>; if(Glyph == "Þ") return <-241.01, 480, 29.98>; if(Glyph == "ß") return <-241.60, 544, 28.81>;
	if(Glyph == "à") return <-243.06, 608, 25.88>; if(Glyph == "á") return <-243.06, 672, 25.88>; if(Glyph == "â") return <-243.06, 736, 25.88>;
	if(Glyph == "ã") return <-243.06, 800, 25.88>; if(Glyph == "ä") return <-243.06, 864, 25.88>; if(Glyph == "å") return <-243.06, 928, 25.88>;
	if(Glyph == "æ") return <-234.21, 992, 43.58>; if(Glyph == "ç") return <-72.26, -992, 26.15>; if(Glyph == "è") return <-71.93, -928, 26.81>;
	if(Glyph == "é") return <-71.93, -864, 26.81>; if(Glyph == "ê") return <-71.93, -800, 26.81>; if(Glyph == "ë") return <-71.93, -736, 26.81>;
	if(Glyph == "ì") return <-80.18, -672, 10.30>; if(Glyph == "í") return <-80.18, -608, 10.30>; if(Glyph == "î") return <-80.18, -544, 10.30>;
	if(Glyph == "ï") return <-80.18, -480, 10.30>; if(Glyph == "ð") return <-71.64, -416, 27.39>; if(Glyph == "ñ") return <-71.66, -352, 27.34>;
	if(Glyph == "ò") return <-71.61, -288, 27.44>; if(Glyph == "ó") return <-71.61, -224, 27.44>; if(Glyph == "ô") return <-71.61, -160, 27.44>;
	if(Glyph == "õ") return <-71.61, -96, 27.44>; if(Glyph == "ö") return <-71.61, -32, 27.44>; if(Glyph == "÷") return <-69.64, 32, 31.40>;
	if(Glyph == "ø") return <-71.61, 96, 27.44>; if(Glyph == "ù") return <-71.66, 160, 27.34>; if(Glyph == "ú") return <-71.66, 224, 27.34>;
	if(Glyph == "û") return <-71.66, 288, 27.34>; if(Glyph == "ü") return <-71.66, 352, 27.34>; if(Glyph == "ý") return <-72.54, 416, 25.59>;
	if(Glyph == "þ") return <-71.20, 480, 28.27>; if(Glyph == "ÿ") return <-72.54, 544, 25.59>; if(Glyph == "‐") return <-77.15, 608, 16.36>;
	if(Glyph == "‑") return <-77.15, 672, 16.36>; if(Glyph == "‒") return <-69.22, 736, 32.23>; if(Glyph == "–") return <-72.83, 800, 25.00>;
	if(Glyph == "—") return <-60.33, 864, 50.00>; if(Glyph == "―") return <-60.33, 928, 50.00>; if(Glyph == "‖") return <-74.27, 992, 22.12>;
	if(Glyph == "‗") return <95.86, -992, 21.04>; if(Glyph == "‘") return <90.09, -928, 9.52>; if(Glyph == "’") return <90.09, -864, 9.52>;
	if(Glyph == "‚") return <89.73, -800, 8.79>; if(Glyph == "‛") return <90.09, -736, 9.52>; if(Glyph == "“") return <93.81, -672, 16.94>;
	if(Glyph == "”") return <93.83, -608, 16.99>; if(Glyph == "„") return <93.46, -544, 16.26>; if(Glyph == "‟") return <93.83, -480, 16.99>;
	if(Glyph == "†") return <96.73, -416, 22.80>; if(Glyph == "‡") return <96.73, -352, 22.80>; if(Glyph == "•") return <97.83, -288, 25.00>;
	if(Glyph == "‣") return <97.83, -224, 25.00>; if(Glyph == "․") return <90.83, -160, 10.99>; if(Glyph == "‥") return <96.32, -96, 21.97>;
	if(Glyph == "…") return <101.81, -32, 32.96>; if(Glyph == "‧") return <90.83, 32, 10.99>; if(Glyph == "′") return <90.05, 96, 9.42>;
	if(Glyph == "″") return <94.76, 160, 18.85>; if(Glyph == "‴") return <99.47, 224, 28.27>; if(Glyph == "‵") return <90.05, 288, 9.42>;
	if(Glyph == "‶") return <94.76, 352, 18.85>; if(Glyph == "‷") return <99.47, 416, 28.27>; if(Glyph == "‸") return <95.78, 480, 20.90>;
	if(Glyph == "‹") return <93.45, 544, 16.24>; if(Glyph == "›") return <93.45, 608, 16.24>; if(Glyph == "‽") return <97.64, 672, 24.61>;
	if(Glyph == "Ā") return <101.67, 736, 32.67>; if(Glyph == "ā") return <98.27, 800, 25.88>; if(Glyph == "Ă") return <101.67, 864, 32.67>;
	if(Glyph == "ă") return <98.27, 928, 25.88>; if(Glyph == "Ą") return <101.67, 992, 32.67>; if(Glyph == "ą") return <268.94, -992, 25.88>;
	if(Glyph == "Ć") return <274.05, -928, 36.11>; if(Glyph == "ć") return <269.07, -864, 26.15>; if(Glyph == "Ĉ") return <274.05, -800, 36.11>;
	if(Glyph == "ĉ") return <269.07, -736, 26.15>; if(Glyph == "Ċ") return <274.05, -672, 36.11>; if(Glyph == "ċ") return <269.07, -608, 26.15>;
	if(Glyph == "Č") return <274.05, -544, 36.11>; if(Glyph == "č") return <269.07, -480, 26.15>; if(Glyph == "Ď") return <273.24, -416, 34.47>;
	if(Glyph == "ď") return <272.58, -352, 33.15>; if(Glyph == "Đ") return <274.08, -288, 36.16>; if(Glyph == "đ") return <270.14, -224, 28.27>;
	if(Glyph == "Ē") return <270.49, -160, 28.98>; if(Glyph == "ē") return <269.40, -96, 26.81>; if(Glyph == "Ĕ") return <270.49, -32, 28.98>;
	if(Glyph == "ĕ") return <269.40, 32, 26.81>; if(Glyph == "Ė") return <270.49, 96, 28.98>; if(Glyph == "ė") return <269.40, 160, 26.81>;
	if(Glyph == "Ę") return <270.49, 224, 28.98>; if(Glyph == "ę") return <269.40, 288, 26.81>; if(Glyph == "Ě") return <270.49, 352, 28.98>;
	if(Glyph == "ě") return <269.40, 416, 26.81>; if(Glyph == "Ĝ") return <274.26, 480, 36.52>; if(Glyph == "ĝ") return <270.14, 544, 28.27>;
	if(Glyph == "Ğ") return <274.26, 608, 36.52>; if(Glyph == "ğ") return <270.14, 672, 28.27>; if(Glyph == "Ġ") return <274.26, 736, 36.52>;
	if(Glyph == "ġ") return <270.14, 800, 28.27>; if(Glyph == "Ģ") return <274.26, 864, 36.52>; if(Glyph == "ģ") return <270.14, 928, 28.27>;
	if(Glyph == "Ĥ") return <273.70, 992, 35.40>; if(Glyph == "ĥ") return <440.34, -992, 27.34>; if(Glyph == "Ħ") return <444.90, -928, 36.47>;
	if(Glyph == "ħ") return <440.34, -864, 27.34>; if(Glyph == "Ĩ") return <432.48, -800, 11.62>; if(Glyph == "ĩ") return <431.82, -736, 10.30>;
	if(Glyph == "Ī") return <432.48, -672, 11.62>; if(Glyph == "ī") return <431.82, -608, 10.30>; if(Glyph == "Ĭ") return <432.48, -544, 11.62>;
	if(Glyph == "ĭ") return <431.82, -480, 10.30>; if(Glyph == "Į") return <432.48, -416, 11.62>; if(Glyph == "į") return <431.82, -352, 10.30>;
	if(Glyph == "İ") return <432.48, -288, 11.62>; if(Glyph == "ı") return <431.82, -224, 10.30>; if(Glyph == "Ĳ") return <445.84, -160, 38.35>;
	if(Glyph == "ĳ") return <436.97, -96, 20.61>; if(Glyph == "Ĵ") return <440.03, -32, 26.73>; if(Glyph == "ĵ") return <431.82, 32, 10.30>;
	if(Glyph == "Ķ") return <442.52, 96, 31.71>; if(Glyph == "ķ") return <439.35, 160, 25.37>; if(Glyph == "ĸ") return <438.84, 224, 24.34>;
	if(Glyph == "Ĺ") return <440.05, 288, 26.76>; if(Glyph == "ĺ") return <431.82, 352, 10.30>; if(Glyph == "Ļ") return <440.05, 416, 26.76>;
	if(Glyph == "ļ") return <431.82, 480, 10.30>; if(Glyph == "Ľ") return <440.05, 544, 26.76>; if(Glyph == "ľ") return <434.26, 608, 15.19>;
	if(Glyph == "Ŀ") return <439.95, 672, 26.56>; if(Glyph == "ŀ") return <434.87, 736, 16.41>; if(Glyph == "Ł") return <440.78, 800, 28.22>;
	if(Glyph == "ł") return <431.82, 864, 10.30>; if(Glyph == "Ń") return <444.42, 928, 35.50>; if(Glyph == "ń") return <440.34, 992, 27.34>;
	if(Glyph == "Ņ") return <615.08, -992, 35.50>; if(Glyph == "ņ") return <611.01, -928, 27.34>; if(Glyph == "Ň") return <615.08, -864, 35.50>;
	if(Glyph == "ň") return <611.01, -800, 27.34>; if(Glyph == "ŉ") return <611.24, -736, 27.81>; if(Glyph == "Ŋ") return <615.08, -672, 35.50>;
	if(Glyph == "ŋ") return <611.01, -608, 27.34>; if(Glyph == "Ō") return <616.06, -544, 37.45>; if(Glyph == "ō") return <611.05, -480, 27.44>;
	if(Glyph == "Ŏ") return <616.06, -416, 37.45>; if(Glyph == "ŏ") return <611.05, -352, 27.44>; if(Glyph == "Ő") return <616.06, -288, 37.45>;
	if(Glyph == "ő") return <611.05, -224, 27.44>; if(Glyph == "Œ") return <622.03, -160, 49.39>; if(Glyph == "œ") return <620.64, -96, 46.61>;
	if(Glyph == "Ŕ") return <613.14, -32, 31.62>; if(Glyph == "ŕ") return <605.39, 32, 16.11>; if(Glyph == "Ŗ") return <613.14, 96, 31.62>;
	if(Glyph == "ŗ") return <605.39, 160, 16.11>; if(Glyph == "Ř") return <613.14, 224, 31.62>; if(Glyph == "ř") return <605.39, 288, 16.11>;
	if(Glyph == "Ś") return <612.69, 352, 30.71>; if(Glyph == "ś") return <609.20, 416, 23.73>; if(Glyph == "Ŝ") return <612.69, 480, 30.71>;
	if(Glyph == "ŝ") return <609.20, 544, 23.73>; if(Glyph == "Ş") return <612.69, 608, 30.71>; if(Glyph == "ş") return <609.20, 672, 23.73>;
	if(Glyph == "Š") return <612.69, 736, 30.71>; if(Glyph == "š") return <609.20, 800, 23.73>; if(Glyph == "Ţ") return <612.59, 864, 30.52>;
	if(Glyph == "ţ") return <605.11, 928, 15.55>; if(Glyph == "Ť") return <612.59, 992, 30.52>; if(Glyph == "ť") return <777.00, -992, 17.99>;
	if(Glyph == "Ŧ") return <783.26, -928, 30.52>; if(Glyph == "ŧ") return <775.78, -864, 15.55>; if(Glyph == "Ũ") return <785.58, -800, 35.16>;
	if(Glyph == "ũ") return <781.67, -736, 27.34>; if(Glyph == "Ū") return <785.58, -672, 35.16>; if(Glyph == "ū") return <781.67, -608, 27.34>;
	if(Glyph == "Ŭ") return <785.58, -544, 35.16>; if(Glyph == "ŭ") return <781.67, -480, 27.34>; if(Glyph == "Ů") return <785.58, -416, 35.16>;
	if(Glyph == "ů") return <781.67, -352, 27.34>; if(Glyph == "Ű") return <785.58, -288, 35.16>; if(Glyph == "ű") return <781.67, -224, 27.34>;
	if(Glyph == "Ų") return <785.58, -160, 35.16>; if(Glyph == "ų") return <781.67, -96, 27.34>; if(Glyph == "Ŵ") return <791.73, -32, 47.46>;
	if(Glyph == "ŵ") return <786.80, 32, 37.60>; if(Glyph == "Ŷ") return <784.06, 96, 32.13>; if(Glyph == "ŷ") return <780.79, 160, 25.59>;
	if(Glyph == "Ÿ") return <784.06, 224, 32.13>; if(Glyph == "Ź") return <783.33, 288, 30.66>; if(Glyph == "ź") return <779.96, 352, 23.93>;
	if(Glyph == "Ż") return <783.33, 416, 30.66>; if(Glyph == "ż") return <779.96, 480, 23.93>; if(Glyph == "Ž") return <783.33, 544, 30.66>;
	if(Glyph == "ž") return <779.96, 608, 23.93>; if(Glyph == "ſ") return <774.24, 672, 12.48>; if(Glyph == "ƀ") return <782.14, 736, 28.27>;
	if(Glyph == "Ɓ") return <787.37, 800, 38.75>; if(Glyph == "Ƃ") return <783.55, 864, 31.10>; if(Glyph == "ƃ") return <782.14, 928, 28.27>;
	if(Glyph == "Ƅ") return <786.32, 992, 36.65>; if(Glyph == "ƅ") return <954.35, -992, 31.37>; if(Glyph == "Ɔ") return <956.72, -928, 36.11>;
	if(Glyph == "Ƈ") return <956.72, -864, 36.11>; if(Glyph == "ƈ") return <954.23, -800, 31.13>; if(Glyph == "Ɖ") return <956.75, -736, 36.16>;
	if(Glyph == "Ɗ") return <959.32, -672, 41.31>; if(Glyph == "Ƌ") return <953.66, -608, 29.98>; if(Glyph == "ƌ") return <952.80, -544, 28.27>;
	if(Glyph == "ƍ") return <951.39, -480, 25.44>; if(Glyph == "Ǝ") return <953.16, -416, 28.98>; if(Glyph == "Ə") return <956.93, -352, 36.52>;
	if(Glyph == "Ɛ") return <953.63, -288, 29.93>; if(Glyph == "Ƒ") return <952.52, -224, 27.71>; if(Glyph == "ƒ") return <947.55, -160, 17.77>;
	if(Glyph == "Ɠ") return <956.93, -96, 36.52>; if(Glyph == "Ɣ") return <953.66, -32, 29.98>; if(Glyph == "ƕ") return <961.42, 32, 45.51>;
	if(Glyph == "Ɩ") return <944.40, 96, 11.47>; if(Glyph == "Ɨ") return <946.43, 160, 15.53>; if(Glyph == "Ƙ") return <954.68, 224, 32.03>;
	if(Glyph == "ƙ") return <951.35, 288, 25.37>; if(Glyph == "ƚ") return <943.82, 352, 10.30>; if(Glyph == "ƛ") return <953.10, 416, 28.86>;
	if(Glyph == "Ɯ") return <960.47, 480, 43.60>; if(Glyph == "Ɲ") return <956.42, 544, 35.50>; if(Glyph == "ƞ") return <952.34, 608, 27.34>;
	if(Glyph == "Ɵ") return <957.39, 672, 37.45>; if(Glyph == "Ơ") return <957.39, 736, 37.45>; if(Glyph == "ơ") return <952.39, 800, 27.44>;
	if(Glyph == "Ƣ") return <959.47, 864, 41.60>; if(Glyph == "ƣ") return <953.66, 928, 29.98>; if(Glyph == "Ƥ") return <957.38, 992, 37.43>;
	return <0, 0, 0>;
}
