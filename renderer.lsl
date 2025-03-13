#include "header.lsl"

#define PARAMS_CHECK llGetFreeMemory() < 1500

// Initializes the system by checking for Text prims and resetting them
textInit()
{
    TAB = llChar(9);
    TEXTURE_FONT = llLinksetDataRead("NT4_Font_Texture");
    TEXTURE_SIZE = (float)llLinksetDataRead("NT4_Font_TextureSize");
    FONT_SIZE = (float)llLinksetDataRead("NT4_Font_FontSize");
    CELL_SIZE = (float)llLinksetDataRead("NT4_Font_CellSize");
    COLUMN_SIZE = (float)llLinksetDataRead("NT4_Font_ColumnSize");
    FONT_BY_CELL = FONT_SIZE / CELL_SIZE;
    
    Printables = [];
    islandX = islandY = 0;
    islandAvailableWidth = COLUMN_SIZE;
    islandFacesFree = 8;
    Cursor.x = Cursor.y = whitespace = 0;
    
    LinksetResourceSetup("NT4", "Text");
    LinksetResourceReset("NT4", [
        PRIM_POS_LOCAL, <0,0,0>,
        PRIM_SIZE, <.01,.01,01>
    ]);
    LinksetResourceReset("NT4", [
        PRIM_COLOR, ALL_SIDES, Color, 1,
        PRIM_TEXTURE, ALL_SIDES, TEXTURE_FONT, ZERO_VECTOR, ZERO_VECTOR, 0
    ]);
}


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
            if(isNewline)
            {
                textFlush();
                Cursor.x = 0.0;
                Cursor.y -= FontSize * LineHeight * isNewline * FONT_BY_CELL;
                islandX = Cursor.x;
                islandY = Cursor.y;
                
                isNewline = 0;
                whitespace = 0.0;
            }
            
            float edge = Cursor.x * METERS_TO_PIXELS + whitespace;
            float indent = llCeil(edge / tabWidth) * tabWidth;
            indent -= edge;
            if(indent < 12.5) indent += tabWidth;
            whitespace += indent;
        }
        else if(char == "\n")
        {
            isNewline++; // Newline
            whitespace = 0.0; // Reset whitespace
        }
        
        else
        {
            string json = llLinksetDataRead("NT4_Font_" + char);
            if(json == "") json = llLinksetDataRead("NT4_Font_" + (char = "�")); // Use replacement character when unknown
            
            list glyphMetrics = llJson2List(json);
            float glyphWidth = llList2Float(glyphMetrics, 0);
            float glyphLeftGap = llList2Float(glyphMetrics, 1);
            float glyphRightGap = llList2Float(glyphMetrics, 2);
            
            // Move cursor forward by whitespace
            Cursor.x += whitespace * PIXELS_TO_METERS;
            
            // Where are we right now on the island
            float islandEnd = (Cursor.x - islandX) * METERS_TO_PIXELS;
            
            // Are we out of faces to display on this island?
            integer outOfFaces = (islandFacesFree == 0);
            
            // Do we need to split the island in two?
            // - Is the glyph wider than the available space left on the island?
            // - Or is there not enough of a transparent gap to the left of the glyph to place it here?
            integer needsSplit = (glyphWidth > islandAvailableWidth - whitespace) + (islandEnd + glyphWidth*.5 > glyphLeftGap);
            
            // Does the text need to wrap?
            integer isWrapping = (Cursor.x + glyphWidth * PIXELS_TO_METERS > TextWrapLength);
            
            // Before add the glyph, do we need to put it on a different island?
            if(outOfFaces || needsSplit || isWrapping || isNewline)
            {
                // list reason;
                // if(outOfFaces) reason += "no faces";
                // if(needsSplit) reason += "needs split";
                // if(isWrapping) reason += "wrapping";
                // if(isNewline) reason += "newline";
                // llOwnerSay("Flush island (" + llList2CSV(reason) + ") " + llInsertString(txt, index, "|")); // + llGetSubString(txt, lastPrintStart, printEnd) + """);
                
                
                // Did we have an island with any glyphs? If so, flush it into the Printables
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
                    if(isNewline) Cursor.x = whitespace * PIXELS_TO_METERS; else Cursor.x = 0;
                    if(isNewline) Cursor.y -= FontSize * LineHeight * isNewline * FONT_BY_CELL;
                    else Cursor.y -= FontSize * LineHeight * FONT_BY_CELL;
                    islandX = Cursor.x;
                    islandY = Cursor.y;
                }
                
                // Reset anything else
                islandEnd = 0;
            }
            
            // if(!isWrapping)
            // {
                // Take off available width on the island by what we are adding
                islandAvailableWidth -= whitespace + glyphWidth;
                
                // Check the transparent gap on the right of the glyph for enough room
                if(glyphRightGap < islandAvailableWidth) islandAvailableWidth = glyphRightGap;
                
                // Now we are moving onto adding the glyph onto our working island
                float pos = islandEnd + glyphWidth/2;
                if(islandFacesFree == 8) { islandChar0 = char; islandPos0 = pos; } else
                if(islandFacesFree == 7) { islandChar1 = char; islandPos1 = pos; } else
                if(islandFacesFree == 6) { islandChar2 = char; islandPos2 = pos; } else
                if(islandFacesFree == 5) { islandChar3 = char; islandPos3 = pos; } else
                if(islandFacesFree == 4) { islandChar4 = char; islandPos4 = pos; } else
                if(islandFacesFree == 3) { islandChar5 = char; islandPos5 = pos; } else
                if(islandFacesFree == 2) { islandChar6 = char; islandPos6 = pos; } else
                if(islandFacesFree == 1) { islandChar7 = char; islandPos7 = pos; }
                
                Cursor.x += glyphWidth * PIXELS_TO_METERS;
                islandFacesFree--;
            // }
            
            isNewline = 0;
            whitespace = 0.0;
        }
    }
    
    if(isNewline)
    {
        textFlush();
        Cursor.x = 0.0;
        Cursor.y -= FontSize * LineHeight * isNewline * FONT_BY_CELL;
        islandX = Cursor.x;
        islandY = Cursor.y;
    }
    
    whitespace = 0.0;
    isNewline = FALSE;
}


textFlush()
{
    if(islandFacesFree == 8) return;
    
    Printables += [
        islandX,
        islandY,
        Cursor.x - islandX,
        islandAvailableWidth,
        FontSize,
        8 - islandFacesFree
        // char
        // pos
    ];
    
    if(islandFacesFree++ < 8) { Printables += islandChar0; Printables += islandPos0; }
    if(islandFacesFree++ < 8) { Printables += islandChar1; Printables += islandPos1; }
    if(islandFacesFree++ < 8) { Printables += islandChar2; Printables += islandPos2; }
    if(islandFacesFree++ < 8) { Printables += islandChar3; Printables += islandPos3; }
    if(islandFacesFree++ < 8) { Printables += islandChar4; Printables += islandPos4; }
    if(islandFacesFree++ < 8) { Printables += islandChar5; Printables += islandPos5; }
    if(islandFacesFree++ < 8) { Printables += islandChar6; Printables += islandPos6; }
    if(islandFacesFree++ < 8) { Printables += islandChar7; Printables += islandPos7; }
    
    // Reset to new working island
    islandX = Cursor.x;
    islandAvailableWidth = COLUMN_SIZE;
    islandFacesFree = 8;
}


list textRender()
{
    list renderables = [];
    float width;
    float height;
    
    textFlush();
    
    float minWidth = .01; // * METERS_TO_PIXELS; // Smallest prim size possible
    
    // Render Printables into prim params for glyph texture coordinates, locations and sizes
    if(Printables)
    {
        list params = [];
        while(Printables)
        {
            float isleX = llList2Float(Printables, 0);
            float isleY = llList2Float(Printables, 1);
            float isleWidth = llList2Float(Printables, 2);
            float isleFontSize = llList2Float(Printables, 4);
            integer faces = llList2Integer(Printables, 5);
            list isleGlyphs = llList2List(Printables, 6, 5 + faces*2);
            Printables = llDeleteSubList(Printables, 0, 5 + faces*2);
            
            PIXELS_TO_METERS = isleFontSize / CELL_SIZE;
            
            if(isleWidth < minWidth) isleWidth = minWidth;
            
            isleWidth /= PIXELS_TO_METERS;
            
            integer linkTarget = LinksetResourceReserve("NT4");
            params += [PRIM_LINK_TARGET, linkTarget];
            
            vector repeats = <isleWidth / TEXTURE_SIZE, CELL_SIZE / TEXTURE_SIZE, 0>;
            while(faces --> 0)
            {
                string char = llList2String(isleGlyphs, faces*2);
                float islePosition = llList2Float(isleGlyphs, faces*2 + 1);
                list glyphMetrics = llJson2List(llLinksetDataRead("NT4_Font_" + char));
                vector coords = <llList2Float(glyphMetrics, 3), llList2Float(glyphMetrics, 4), 0>;
                
                coords.x = (coords.x - islePosition) + isleWidth/2;
                coords /= TEXTURE_SIZE;
                params += [PRIM_COLOR, 7 - faces, Color, 1, PRIM_TEXTURE, 7 - faces, TEXTURE_FONT, repeats, coords, 0];
            }
            
            isleWidth *= PIXELS_TO_METERS;
            
            // isleX *= PIXELS_TO_METERS;
            // isleY *= PIXELS_TO_METERS;
            // isleWidth *= PIXELS_TO_METERS;
            
            isleX += isleWidth / 2;
            isleY += isleFontSize * 0.25;
            
            vector position = <0, isleX, isleY> * Direction;
            params += [
                PRIM_POS_LOCAL, Anchor + position,
                PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
                PRIM_SIZE, <isleWidth, isleFontSize, 0.01>
            ];
            
            if(PARAMS_CHECK)
            {
                llSetLinkPrimitiveParamsFast(0, params);
                params = [];
            }
            
            
            if(isleX + isleWidth > width) width = isleX + isleWidth/2;
            if(isleY + isleFontSize > height) height = isleY + isleFontSize;
            renderables += [linkTarget, position];
        }
        
        if(params) llSetLinkPrimitiveParamsFast(0, params);
    }
    
    Printables = [];
    return [width, height] + renderables;
}


textBin(list render)
{
    list params = [];
    string links = llLinksetDataRead("NT4");
    integer index = 2;
    integer total = llGetListLength(render);
    for(; index < total; index += 2)
    {
        integer link = llList2Integer(render, index);
        links += llChar(link - 1);
        params += [
            PRIM_LINK_TARGET, link,
            PRIM_POS_LOCAL, <0,0,0>,
            PRIM_SIZE, <.01,.01,01>,
            PRIM_COLOR, ALL_SIDES, Color, 1,
            PRIM_TEXTURE, ALL_SIDES, TEXTURE_FONT, ZERO_VECTOR, ZERO_VECTOR, 0
        ];
    }
    llLinksetDataWrite("NT4", links);
    llSetLinkPrimitiveParamsFast(0, params);
}




