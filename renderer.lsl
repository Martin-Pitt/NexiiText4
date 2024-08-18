#include "header.lsl"

#define MAX_PARAMS 100


// Current working island
float islandX;
float islandY;
float islandAvailableWidth = COLUMN_SIZE;
vector islandGlyph0;
vector islandGlyph1;
vector islandGlyph2;
vector islandGlyph3;
vector islandGlyph4;
vector islandGlyph5;
vector islandGlyph6;
vector islandGlyph7;
integer facesLeft = 8;

list printables = [];

float METERS_TO_PIXELS;
float PIXELS_TO_METERS;
float wrapLength;
float tabWidth;
float whitespace;
integer isNewline;

text(string txt)
{
    // Constants
    METERS_TO_PIXELS = CELL_SIZE / FontSize;
    PIXELS_TO_METERS = FontSize / CELL_SIZE;
    tabWidth = 12.5 * TabSize;
    
    // Check if we had a working island before
    if(Cursor.y != islandY) textFlush();
    
    integer index = 0; integer total = llStringLength(txt);
    for(; index < total; ++index)
    {
        string char = llGetSubString(txt, index, index);
        if(char == " ") { whitespace += 12.5; } // Space
        else if(char == " ") { whitespace += 25; } // EN Space
        else if(char == " ") { whitespace += 50; } // EM Space
        else if(char == " ") { whitespace += 16.69921875; } // Three-per-EM Space
        else if(char == " ") { whitespace += 12.5; } // Four-per-EM Space
        else if(char == " ") { whitespace += 8.30078125; } // Six-per-EM Space
        else if(char == " ") { whitespace += 32.2265625; } // Figure Space
        else if(char == " ") { whitespace += 10.986328125; } // Punctuation Space
        else if(char == " ") { whitespace += 7.51953125; } // Thin Space
        else if(char == " ") { whitespace += 2.978515625; } // Hair Space
        else if(char == TAB) { // Tab indentation
            float indent = llCeil((Cursor.x * METERS_TO_PIXELS + whitespace) / tabWidth) * tabWidth;
            indent -= (Cursor.x * METERS_TO_PIXELS + whitespace);
            if(indent < 12.5) indent += tabWidth;
            whitespace += indent;
        }
        else if(char == "\n") isNewline++; // Newline
        
        else
        {
            integer lookup = GlyphIndex(char);
            if(lookup == -1) lookup = 0; // Use replacement character when unknown
            
            // Get a glyph spec in format of <width, left gap, and right gap>
            vector spec = GlyphSpec(lookup);
            
            // Move cursor forward by whitespace
            Cursor.x += whitespace * PIXELS_TO_METERS;
            
            // Where are we right now on the island
            float islandEnd = Cursor.x - islandX;
            
            // Are we out of faces to display on this island?
            integer outOfFaces = (facesLeft == 0);
            
            // Do we need to split the island in two?
            // - Is the glyph wider than the available space left on the island?
            // - Or is there not enough of a transparent gap to the left of the glyph to place it here?
            integer needsSplit = (spec.x > islandAvailableWidth - whitespace) || (islandEnd > spec.y);
            
            // Does the text need to wrap?
            integer isWrapping = (Cursor.x + spec.x * PIXELS_TO_METERS > TextWrapLength);
            
            // Before add the glyph, do we need to put it on a different island?
            if(outOfFaces || needsSplit || isWrapping || isNewline)
            {
                // list reason;
                // if(outOfFaces) reason += "no faces";
                // if(needsSplit) reason += "needs split";
                // if(isWrapping) reason += "wrapping";
                // if(isNewline) reason += "newline";
                // llOwnerSay("Flush island (" + llList2CSV(reason) + ") " + llInsertString(txt, index, "|")); // + llGetSubString(txt, lastPrintStart, printEnd) + """);
                
                
                // Did we have an island with any glyphs? If so, flush it into the printables
                Cursor.x -= whitespace * PIXELS_TO_METERS;
                textFlush();
                Cursor.x += whitespace * PIXELS_TO_METERS;
                
                // Did we wrap? Also if we were only whitespace, just drop down
                // if(isWrapping && lastSpaceIndex && lastSpacePos > wrapLength)
                // {
                //     // Undoing glyphs on current
                //     while(Cursor.x > lastSpacePos)
                //     {
                //         Cursor.x -= glyph.z;
                //         lastPrintPos = Cursor.x;
                //         glyph = llList2Rot(glyphs, -1);
                //         glyphs = llDeleteSubList(glyphs, -1, -1);
                //     }
                    
                //     Cursor.x = lastSpacePos;
                //     index = lastSpaceIndex;
                // }
                
                
                
                // Split the island to where we are at
                if(outOfFaces || needsSplit)
                {
                    islandX = Cursor.x;
                }
                
                // Reset onto new line
                if(isWrapping || isNewline)
                {
                    Cursor.x = 0.0;
                    if(isNewline) Cursor.y -= FontSize * LineHeight * isNewline * FONT_SIZE / CELL_SIZE;
                    else Cursor.y -= FontSize * LineHeight * FONT_SIZE / CELL_SIZE;
                    islandX = Cursor.x;
                    islandY = Cursor.y;
                }
                
                // Reset anything else
                islandEnd = 0;
            }
            
            // if(!isWrapping)
            // {
                // Take off available width on the island by what we are adding
                islandAvailableWidth -= whitespace + spec.x;
                
                // Check the transparent gap on the right of the glyph for enough room
                if(spec.z < islandAvailableWidth) islandAvailableWidth = spec.z;
                
                // Now we are moving onto adding the glyph onto our working island
                vector glyph = <lookup, islandEnd * METERS_TO_PIXELS + spec.x/2, 0>;
                if(facesLeft == 8) islandGlyph0 = glyph; else
                if(facesLeft == 7) islandGlyph1 = glyph; else
                if(facesLeft == 6) islandGlyph2 = glyph; else
                if(facesLeft == 5) islandGlyph3 = glyph; else
                if(facesLeft == 4) islandGlyph4 = glyph; else
                if(facesLeft == 3) islandGlyph5 = glyph; else
                if(facesLeft == 2) islandGlyph6 = glyph; else
                if(facesLeft == 1) islandGlyph7 = glyph;
                
                Cursor.x += spec.x * PIXELS_TO_METERS;
                facesLeft--;
            // }
            
            isNewline = 0;
            whitespace = 0.0;
        }
    }
    
    // Move cursor forward by remaining whitespace
    // Cursor.x += whitespace;
    if(isNewline)
    {
        Cursor.x -= whitespace * PIXELS_TO_METERS;
        textFlush();
        Cursor.x = 0.0;
        Cursor.y -= FontSize * LineHeight * isNewline * FONT_SIZE / CELL_SIZE;
        islandX = Cursor.x;
        islandY = Cursor.y;
    }
    
    whitespace = 0.0;
    isNewline = FALSE;
}


textFlush()
{
    if(facesLeft == 8) return;
    
    printables += [
        islandX,
        islandY,
        Cursor.x - islandX,
        islandAvailableWidth,
        FontSize,
        8 - facesLeft
    ];
    
    if(facesLeft++ < 8) { printables += (integer)islandGlyph0.x; printables += islandGlyph0.y; }
    if(facesLeft++ < 8) { printables += (integer)islandGlyph1.x; printables += islandGlyph1.y; }
    if(facesLeft++ < 8) { printables += (integer)islandGlyph2.x; printables += islandGlyph2.y; }
    if(facesLeft++ < 8) { printables += (integer)islandGlyph3.x; printables += islandGlyph3.y; }
    if(facesLeft++ < 8) { printables += (integer)islandGlyph4.x; printables += islandGlyph4.y; }
    if(facesLeft++ < 8) { printables += (integer)islandGlyph5.x; printables += islandGlyph5.y; }
    if(facesLeft++ < 8) { printables += (integer)islandGlyph6.x; printables += islandGlyph6.y; }
    if(facesLeft++ < 8) { printables += (integer)islandGlyph7.x; printables += islandGlyph7.y; }
    
    // Reset to new working island
    islandX = Cursor.x;
    islandAvailableWidth = COLUMN_SIZE;
    islandGlyph0 = islandGlyph1 = islandGlyph2 = islandGlyph3 = islandGlyph4 = islandGlyph5 = islandGlyph6 = islandGlyph7 = ZERO_VECTOR;
    facesLeft = 8;
}


list textRender(integer withColor, integer returnRenders)
{
    list returnables = [];
    float width;
    float height;
    
    textFlush();
    
    float minWidth = .01; // * METERS_TO_PIXELS; // Smallest prim size possible
    
    // Render printables into prim params for glyph texture coordinates, locations and sizes
    if(printables)
    {
        list params = [];
        while(printables)
        {
            float isleX = llList2Float(printables, 0);
            float isleY = llList2Float(printables, 1);
            float isleWidth = llList2Float(printables, 2);
            float isleFontSize = llList2Float(printables, 4);
            integer faces = llList2Integer(printables, 5);
            list isleGlyphs = llList2List(printables, 6, 5 + faces*2);
            printables = llDeleteSubList(printables, 0, 5 + faces*2);
            
            PIXELS_TO_METERS = isleFontSize / CELL_SIZE;
            
            if(isleWidth < minWidth) isleWidth = minWidth;
            
            isleWidth /= PIXELS_TO_METERS;
            
            integer linkTarget = llList2Integer(Free, 0);
            Free = llDeleteSubList(Free, 0, 0);
            Used += linkTarget;
            params += [PRIM_LINK_TARGET, linkTarget];
            
            vector repeats = <isleWidth / TEXTURE_SIZE, CELL_SIZE / TEXTURE_SIZE, 0>;
            while(faces --> 0)
            {
                integer isleLookup = llList2Integer(isleGlyphs, faces*2);
                float islePosition = llList2Float(isleGlyphs, faces*2 + 1);
                vector spec = GlyphSpec(isleLookup);
                vector coords = GlyphCoords(isleLookup);
                coords.x = (coords.x - islePosition) + isleWidth/2;
                coords /= TEXTURE_SIZE;
                if(withColor) params += [PRIM_COLOR, 7 - faces, Color, 1];
                params += [PRIM_TEXTURE, 7 - faces, TEXTURE_INTER, repeats, coords, 0];
            }
            
            isleWidth *= PIXELS_TO_METERS;
            
            // isleX *= PIXELS_TO_METERS;
            // isleY *= PIXELS_TO_METERS;
            // isleWidth *= PIXELS_TO_METERS;
            
            isleX += isleWidth / 2;
            isleY += isleFontSize * 0.25;
            
            vector position = Anchor + <0, isleX, isleY> * Direction;
            params += [
                PRIM_POS_LOCAL, position,
                PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
                PRIM_SIZE, <isleWidth, isleFontSize, 0.01>,
                
                PRIM_DESC, (string)isleFontSize
            ];
            
            if(llGetListLength(params) > MAX_PARAMS)
            {
                llSetLinkPrimitiveParamsFast(0, params);
                params = [];
            }
            
            if(returnRenders)
            {
                if(isleX + isleWidth > width) width = isleX + isleWidth/2;
                if(isleY + isleFontSize > height) height = isleY + isleFontSize;
                returnables += [linkTarget, position];
            }
        }
        
        if(params) llSetLinkPrimitiveParamsFast(0, params);
    }
    
    printables = [];
    return [width, height] + returnables;
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
