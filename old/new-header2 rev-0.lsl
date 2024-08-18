// #define TEXTURE_INTER "3b9a5f23-9688-3cfe-fb0f-49f91b4d4df3"
#define TEXTURE_INTER "90defec5-3480-ce3a-848d-e85cb4b30e7a"
#define TEXTURE_EIGHT "876a12ca-928e-baf1-a35b-f3aab5db95bc"
#define TEXTURE_SIZE 2048.
#define CELL_SIZE 64.
// #define COLUMN_WIDTH 341.3333333333333
// #define COLUMN_WIDTH 170.66666666666666
#define COLUMN_WIDTH 162.


// Resources
list Free;
list Used;


// Settings
vector Anchor = <0,0,0>;
rotation Direction = <0,0,0,1>;
vector Color = <1,1,1>;
integer FontWeight = 400;
float FontSize = 0.64;
float LineHeight = 1.2;
// string FontFamily = "Inter";
string TextWrap = "wrap"; // "nowrap"
float TextWrapLength = 64.0;
// string TextOverflow = "clip"; // "ellipsis"
// integer TextShadow = FALSE;
// vector TextShadowColor = <0,0,0>;
// vector TextShadowWeight = 700;
// float TextShadowOffsetX = 0.05;
// float TextShadowOffsetY = 0.05;

/*
    Newlines can be created because of:
    1. 
 letter
    2. TextWrap setting
    3. Font column width
    
    Splits happen because:
    1. Out of available faces on the mesh
    2. Not enough room in font texture column
*/


float lastSplit;
float lastPrint;
float lastSpacing;
vector cursor; // = <0, FontSize * LineHeight * -0.5, 0>;
integer facesLeft = 8;
list glyphs;
list printables = [/* x, y, width, link, ...glyphs */];
integer isNewline = FALSE;
integer isWrapping = FALSE;

text(string txt)
{
    integer isDebug = llSubStringIndex(txt, "long");
    if(isDebug != -1) llOwnerSay("isDebug on: " + txt);
    float wrapLength = TextWrapLength / FontSize * CELL_SIZE;
    // float lastSplit = 0.0;
    // float lastPrint = 0.0;
    lastSpacing = 0.0; // Can only use this if the txt had the whitespace character
    integer lastSpace;
    // vector cursor = <0, FontSize * LineHeight * -0.5, 0>;
    float width;
    // integer facesLeft = 8;
    // list glyphs;
    // list printables;
    // integer isNewline = FALSE;
    integer index;
    integer total;
    for(total = llStringLength(txt); index < total; ++index)
    {
        string letter = llGetSubString(txt, index, index);
        
        // Handling spacing characters
        if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 12.5; } // Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 25; } // EN Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 50; } // EM Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 16.69921875; } // Three-per-EM Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 12.5; } // Four-per-EM Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 8.30078125; } // Six-per-EM Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 32.2265625; } // Figure Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 10.986328125; } // Punctuation Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 7.51953125; } // Thin Space
        else if(letter == " ") { lastSpace = index; lastSpacing = cursor.x += 2.978515625; } // Hair Space
        else if(letter == "\n") isNewline = TRUE; // Newline
        
        // Others
        else
        {
            vector glyph = Glyphs(letter);
            if(glyph != ZERO_VECTOR)
            {
                width = cursor.x - lastSplit;
                integer needsSplit = FALSE;
                if(!facesLeft) needsSplit = TRUE;
                else if(width + glyph.z >= COLUMN_WIDTH) needsSplit = TRUE;
                
                // if(TextWrap == "wrap" && (width + glyph.z > wrapLength)) isNewline = TRUE;
                if(cursor.x + glyph.z > wrapLength) isWrapping = TRUE;
                
                if(needsSplit || isWrapping || isNewline)
                {
                    // Did we wrap? Also if we were only whitespace, just drop down
                    if(isWrapping && lastSpacing > 0.0 && lastSpacing > wrapLength)
                    {
                        // if(isDebug != -1 && isDebug <= index && index <= isDebug + 13)
                        // {
                            llOwnerSay("isWrapping (whitespace)\n"
                                + "lastSpacing: " + (string)lastSpacing + "\n"
                                + "cursor.x: " + (string)cursor.x + "\n"
                                + llGetSubString(txt, index - 4, index - 1) + "|" + llGetSubString(txt, index, index + 6) + "…"
                            );
                        // }
                        
                        while(cursor.x > lastSpacing)
                        {
                            lastPrint = cursor.x -= glyph.z;
                            glyph = llList2Vector(glyphs, -1);
                        }
                        
                        cursor.x = lastSpacing;
                        index = lastSpace;
                    }
                    
                    // Did we wrap? And was there a whitespace on this line?
                    else if(isWrapping && lastSpacing > 0.0)
                    {
                        llOwnerSay("isWrapping (word-wrap)\n"
                            + "lastSpacing: " + (string)lastSpacing + "\n"
                            + "cursor.x: " + (string)cursor.x + "\n"
                            + llGetSubString(txt, index - 4, index - 1) + "|" + llGetSubString(txt, index, index + 6) + "…"
                        );
                    }
                    
                    
                    if(glyphs)
                    {
                        if(isDebug != -1 && isDebug <= index && index <= isDebug + 13)
                        {
                            list t = [];
                            if(needsSplit) t += "needsSplit";
                            if(isWrapping) t += "isWrapping";
                            if(isNewline) t += "isNewline";
                            llOwnerSay("Flushing glyphs to printable (" + llList2CSV(t) + ")");
                        }
                        
                        integer linkTarget = llList2Integer(Free, 0);
                        Free = llDeleteSubList(Free, 0, 0);
                        Used += linkTarget;
                        printables += [
                            lastSplit,
                            cursor.y,
                            lastPrint - lastSplit,
                            linkTarget,
                            llGetListLength(glyphs)
                        ] + glyphs;
                    }
                    
                    
                    if(needsSplit)
                    {
                        lastSplit = cursor.x;
                    }
                    
                    if(isWrapping || isNewline)
                    {
                        lastSplit = 0.0;
                        lastPrint = 0.0;
                        lastSpacing = 0.0;
                        cursor.x = 0.0;
                        cursor.y -= FontSize * LineHeight;
                    }
                    
                    // lastSpacing = 0.0; //- For now only consider if same printable
                    width = 0;
                    facesLeft = 8;
                    glyphs = [];
                }
                
                if(!isWrapping)
                {
                    if(isDebug != -1 && isDebug <= index && index <= isDebug + 13)
                    {
                        llOwnerSay("Adding glyph " + letter);
                    }
                    
                    glyphs += <glyph.x - glyph.z/2, glyph.y, width>;
                    cursor.x += glyph.z;
                    lastPrint = cursor.x;
                    facesLeft--;
                }
                
                needsSplit = isWrapping = isNewline = FALSE;
            }
        }
    }
}

textStyle()
{
    if(glyphs)
    {
        integer linkTarget = llList2Integer(Free, 0);
        Free = llDeleteSubList(Free, 0, 0);
        Used += linkTarget;
        
        printables += [
            lastSplit,
            cursor.y,
            lastPrint - lastSplit,
            linkTarget,
            llGetListLength(glyphs)
        ] + glyphs;
        
        glyphs = [];
    }
    
    if(printables)
    {
        integer cutoff = llRound(220. + ((64. - 220.) * ((100. - FontWeight) / (100. - 900.))));
        list params = [];
        integer pointer = 0; integer max = llGetListLength(printables);
        for(; pointer < max;)
        {
            // float x = llList2Float(printables, pointer + 0);
            // float y = llList2Float(printables, pointer + 1);
            // float width = llList2Float(printables, pointer + 2);
            integer linkTarget = llList2Integer(printables, pointer + 3);
            integer total = llList2Integer(printables, pointer + 4);
            glyphs = llList2List(printables, pointer + 5, pointer + 4 + total);
            pointer += 5 + total;
            // printables = llDeleteSubList(printables, 0, 4 + total);
            
            params += [PRIM_LINK_TARGET, linkTarget];
            
            integer index;
            for(index = 0; index < total; ++index)
            {
                vector glyph = llList2Vector(glyphs, index);
                params += [
                    PRIM_COLOR, index, Color, 1,
                    PRIM_ALPHA_MODE, index, PRIM_ALPHA_MODE_MASK, cutoff
                ];
            }
            
            if(llGetListLength(params) > 24)
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
    
    // lastSplit = 0;
    // lastPrint = 0;
    // cursor = <0, 0, 0>; // <0, FontSize * LineHeight * -0.5, 0>;
    // facesLeft = 8;
    glyphs = [];
    // printables = [];
    // isNewline = FALSE;
}

textFlush()
{
    if(glyphs)
    {
        integer linkTarget = llList2Integer(Free, 0);
        Free = llDeleteSubList(Free, 0, 0);
        Used += linkTarget;
        
        printables += [
            lastSplit,
            cursor.y,
            lastPrint - lastSplit,
            linkTarget,
            llGetListLength(glyphs)
        ] + glyphs;
        
        glyphs = [];
    }
    
    if(printables)
    {
        list params = [];
        while(printables)
        {
            float x = llList2Float(printables, 0);
            float y = llList2Float(printables, 1);
            float width = llList2Float(printables, 2);
            integer linkTarget = llList2Integer(printables, 3);
            integer total = llList2Integer(printables, 4);
            glyphs = llList2List(printables, 5, 4 + total);
            printables = llDeleteSubList(printables, 0, 4 + total);
            
            params += [PRIM_LINK_TARGET, linkTarget];
            
            vector repeats = <width / TEXTURE_SIZE, CELL_SIZE / TEXTURE_SIZE, 0>;
            integer index;
            for(index = 0; index < total; ++index)
            {
                vector glyph = llList2Vector(glyphs, index);
                vector offsets = <(glyph.x - glyph.z + width / 2) / TEXTURE_SIZE, glyph.y / -TEXTURE_SIZE, 0>;
                params += [PRIM_TEXTURE, index, TEXTURE_INTER, repeats, offsets, 0];
            }
            
            x += width / 2;
            x = x / CELL_SIZE * FontSize;
            
            params += [
                PRIM_POS_LOCAL, Anchor + <0, x, y> * Direction,
                PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
                PRIM_SIZE, <width / CELL_SIZE * FontSize, FontSize, 0.01>
            ];
            
            if(llGetListLength(params) > 24)
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
    
    lastSplit = 0.0;
    lastPrint = 0.0;
    lastSpacing = 0.0;
    // cursor = <0, 0, 0>; // <0, FontSize * LineHeight * -0.5, 0>;
    facesLeft = 8;
    glyphs = [];
    printables = [];
    isWrapping = FALSE;
    isNewline = FALSE;
}

/*
// Texture coordinates and letter spacing
vector Glyphs(string Glyph) {
	if(Glyph == "0") return <-838.0013020833334, -992, 30.6640625>;
	if(Glyph == "1") return <-844.2757161458334, -928, 18.115234375>;
	if(Glyph == "2") return <-839.3074544270834, -864, 28.0517578125>;
	if(Glyph == "3") return <-838.3675130208334, -800, 29.931640625>;
	if(Glyph == "4") return <-837.8914388020834, -736, 30.8837890625>;
	if(Glyph == "5") return <-838.9168294270834, -672, 28.8330078125>;
	if(Glyph == "6") return <-838.7337239583334, -608, 29.19921875>;
	if(Glyph == "7") return <-840.4427083333334, -544, 25.78125>;
	if(Glyph == "8") return <-838.7825520833334, -480, 29.1015625>;
	if(Glyph == "9") return <-838.7337239583334, -416, 29.19921875>;
	if(Glyph == "a") return <-840.3938802083334, -352, 25.87890625>;
	if(Glyph == "b") return <-839.1975911458334, -288, 28.271484375>;
	if(Glyph == "c") return <-840.2596028645834, -224, 26.1474609375>;
	if(Glyph == "d") return <-839.1975911458334, -160, 28.271484375>;
	if(Glyph == "e") return <-839.9300130208334, -96, 26.806640625>;
	if(Glyph == "f") return <-845.6795247395834, -32, 15.3076171875>;
	if(Glyph == "g") return <-839.1975911458334, 32, 28.271484375>;
	if(Glyph == "h") return <-839.6614583333334, 96, 27.34375>;
	if(Glyph == "i") return <-848.1819661458334, 160, 10.302734375>;
	if(Glyph == "j") return <-848.1819661458334, 224, 10.302734375>;
	if(Glyph == "k") return <-840.6502278645834, 288, 25.3662109375>;
	if(Glyph == "l") return <-848.1819661458334, 352, 10.302734375>;
	if(Glyph == "m") return <-832.3616536458334, 416, 41.943359375>;
	if(Glyph == "n") return <-839.6614583333334, 480, 27.34375>;
	if(Glyph == "o") return <-839.6126302083334, 544, 27.44140625>;
	if(Glyph == "p") return <-839.1975911458334, 608, 28.271484375>;
	if(Glyph == "q") return <-839.1975911458334, 672, 28.271484375>;
	if(Glyph == "r") return <-845.2766927083334, 736, 16.11328125>;
	if(Glyph == "s") return <-841.4680989583334, 800, 23.73046875>;
	if(Glyph == "t") return <-845.5574544270834, 864, 15.5517578125>;
	if(Glyph == "u") return <-839.6614583333334, 928, 27.34375>;
	if(Glyph == "v") return <-840.5403645833334, 992, 25.5859375>;
	if(Glyph == "w") return <-493.201171875, -992, 37.59765625>;
	if(Glyph == "x") return <-499.3291015625, -928, 25.341796875>;
	if(Glyph == "y") return <-499.20703125, -864, 25.5859375>;
	if(Glyph == "z") return <-500.037109375, -800, 23.92578125>;
	if(Glyph == "A") return <-495.6669921875, -736, 32.666015625>;
	if(Glyph == "B") return <-496.04541015625, -672, 31.9091796875>;
	if(Glyph == "C") return <-493.94580078125, -608, 36.1083984375>;
	if(Glyph == "D") return <-494.763671875, -544, 34.47265625>;
	if(Glyph == "E") return <-497.51025390625, -480, 28.9794921875>;
	if(Glyph == "F") return <-498.14501953125, -416, 27.7099609375>;
	if(Glyph == "G") return <-493.73828125, -352, 36.5234375>;
	if(Glyph == "H") return <-494.2998046875, -288, 35.400390625>;
	if(Glyph == "I") return <-506.189453125, -224, 11.62109375>;
	if(Glyph == "J") return <-498.63330078125, -160, 26.7333984375>;
	if(Glyph == "K") return <-496.14306640625, -96, 31.7138671875>;
	if(Glyph == "L") return <-498.62109375, -32, 26.7578125>;
	if(Glyph == "M") return <-490.564453125, 32, 42.87109375>;
	if(Glyph == "N") return <-494.2509765625, 96, 35.498046875>;
	if(Glyph == "O") return <-493.2744140625, 160, 37.451171875>;
	if(Glyph == "P") return <-496.70458984375, 224, 30.5908203125>;
	if(Glyph == "Q") return <-493.2744140625, 288, 37.451171875>;
	if(Glyph == "R") return <-496.19189453125, 352, 31.6162109375>;
	if(Glyph == "S") return <-496.6435546875, 416, 30.712890625>;
	if(Glyph == "T") return <-496.7412109375, 480, 30.517578125>;
	if(Glyph == "U") return <-494.421875, 544, 35.15625>;
	if(Glyph == "V") return <-495.6669921875, 608, 32.666015625>;
	if(Glyph == "W") return <-488.26953125, 672, 47.4609375>;
	if(Glyph == "X") return <-495.8623046875, 736, 32.275390625>;
	if(Glyph == "Y") return <-495.935546875, 800, 32.12890625>;
	if(Glyph == "Z") return <-496.66796875, 864, 30.6640625>;
	if(Glyph == "!") return <-506.5068359375, 928, 10.986328125>;
	if(Glyph == "\"") return <-501.9169921875, 992, 20.166015625>;
	if(Glyph == "#") return <-155.67643229166674, -992, 29.98046875>;
	if(Glyph == "$") return <-155.31022135416674, -928, 30.712890625>;
	if(Glyph == "%") return <-149.57291666666674, -864, 42.1875>;
	if(Glyph == "&") return <-155.45670572916674, -800, 30.419921875>;
	if(Glyph == "'") return <-164.31901041666674, -736, 12.6953125>;
	if(Glyph == "(") return <-163.19596354166674, -672, 14.94140625>;
	if(Glyph == ")") return <-163.19596354166674, -608, 14.94140625>;
	if(Glyph == "*") return <-158.94791666666674, -544, 23.4375>;
	if(Glyph == "+") return <-154.96842447916674, -480, 31.396484375>;
	if(Glyph == ",") return <-165.17350260416674, -416, 10.986328125>;
	if(Glyph == "-") return <-159.94889322916674, -352, 21.435546875>;
	if(Glyph == ".") return <-165.17350260416674, -288, 10.986328125>;
	if(Glyph == "/") return <-162.53678385416674, -224, 16.259765625>;
	if(Glyph == ":") return <-165.17350260416674, -160, 10.986328125>;
	if(Glyph == ";") return <-165.10026041666674, -96, 11.1328125>;
	if(Glyph == "<") return <-154.96842447916674, -32, 31.396484375>;
	if(Glyph == "=") return <-154.96842447916674, 32, 31.396484375>;
	if(Glyph == ">") return <-154.96842447916674, 96, 31.396484375>;
	if(Glyph == "?") return <-157.56852213541674, 160, 26.1962890625>;
	if(Glyph == "@") return <-146.32584635416674, 224, 48.681640625>;
	if(Glyph == "[") return <-163.19596354166674, 288, 14.94140625>;
	if(Glyph == "\\") return <-162.53678385416674, 352, 16.259765625>;
	if(Glyph == "]") return <-163.19596354166674, 416, 14.94140625>;
	if(Glyph == "^") return <-159.72916666666674, 480, 21.875>;
	if(Glyph == "_") return <-159.31412760416674, 544, 22.705078125>;
	if(Glyph == "{") return <-161.04752604166674, 608, 19.23828125>;
	if(Glyph == "|") return <-163.26920572916674, 672, 14.794921875>;
	if(Glyph == "}") return <-161.04752604166674, 736, 19.23828125>;
	if(Glyph == "~") return <-154.96842447916674, 800, 31.396484375>;
	if(Glyph == "¡") return <-165.02701822916674, 864, 11.279296875>;
	if(Glyph == "¢") return <-157.59293619791674, 928, 26.1474609375>;
	if(Glyph == "£") return <-156.11588541666674, 992, 29.1015625>;
	if(Glyph == "¤") return <187.95182291666674, -992, 34.5703125>;
	if(Glyph == "¥") return <183.58170572916674, -928, 25.830078125>;
	if(Glyph == "¦") return <176.52604166666674, -864, 11.71875>;
	if(Glyph == "§") return <184.09440104166674, -800, 26.85546875>;
	if(Glyph == "¨") return <184.33854166666674, -736, 27.34375>;
	if(Glyph == "©") return <192.73697916666674, -672, 44.140625>;
	if(Glyph == "ª") return <181.21354166666674, -608, 21.09375>;
	if(Glyph == "«") return <183.74039713541674, -544, 26.1474609375>;
	if(Glyph == "¬") return <186.36490885416674, -480, 31.396484375>;
	if(Glyph == "®") return <186.43815104166674, -416, 31.54296875>;
	if(Glyph == "¯") return <180.82291666666674, -352, 20.3125>;
	if(Glyph == "°") return <181.23795572916674, -288, 21.142578125>;
	if(Glyph == "±") return <186.36490885416674, -224, 31.396484375>;
	if(Glyph == "²") return <180.29801432291674, -160, 19.2626953125>;
	if(Glyph == "³") return <180.70084635416674, -96, 20.068359375>;
	if(Glyph == "´") return <176.69694010416674, -32, 12.060546875>;
	if(Glyph == "µ") return <184.48502604166674, 32, 27.63671875>;
	if(Glyph == "¶") return <184.71695963541674, 96, 28.1005859375>;
	if(Glyph == "·") return <176.15983072916674, 160, 10.986328125>;
	if(Glyph == "¸") return <176.55045572916674, 224, 11.767578125>;
	if(Glyph == "¹") return <177.18522135416674, 288, 13.037109375>;
	if(Glyph == "º") return <181.81168619791674, 352, 22.2900390625>;
	if(Glyph == "»") return <183.74039713541674, 416, 26.1474609375>;
	if(Glyph == "¼") return <188.75748697916674, 480, 36.181640625>;
	if(Glyph == "½") return <189.56315104166674, 544, 37.79296875>;
	if(Glyph == "¾") return <190.77164713541674, 608, 40.2099609375>;
	if(Glyph == "¿") return <183.76481119791674, 672, 26.1962890625>;
	if(Glyph == "‐") return <178.84537760416674, 736, 16.357421875>;
	if(Glyph == "‑") return <178.84537760416674, 800, 16.357421875>;
	if(Glyph == "‒") return <186.77994791666674, 864, 32.2265625>;
	if(Glyph == "–") return <183.16666666666674, 928, 25>;
	if(Glyph == "—") return <195.66666666666674, 992, 50>;
	if(Glyph == "―") return <537, -992, 50>;
	if(Glyph == "‖") return <523.0595703125, -928, 22.119140625>;
	if(Glyph == "‗") return <522.5224609375, -864, 21.044921875>;
	if(Glyph == "‘") return <516.7607421875, -800, 9.521484375>;
	if(Glyph == "’") return <516.7607421875, -736, 9.521484375>;
	if(Glyph == "‚") return <516.39453125, -672, 8.7890625>;
	if(Glyph == "‛") return <516.7607421875, -608, 9.521484375>;
	if(Glyph == "“") return <520.4716796875, -544, 16.943359375>;
	if(Glyph == "”") return <520.49609375, -480, 16.9921875>;
	if(Glyph == "„") return <520.1298828125, -416, 16.259765625>;
	if(Glyph == "‟") return <520.49609375, -352, 16.9921875>;
	if(Glyph == "†") return <523.4013671875, -288, 22.802734375>;
	if(Glyph == "‡") return <523.4013671875, -224, 22.802734375>;
	if(Glyph == "•") return <524.5, -160, 25>;
	if(Glyph == "‣") return <524.5, -96, 25>;
	if(Glyph == "․") return <517.4931640625, -32, 10.986328125>;
	if(Glyph == "‥") return <522.986328125, 32, 21.97265625>;
	if(Glyph == "…") return <528.4794921875, 96, 32.958984375>;
	if(Glyph == "‧") return <517.4931640625, 160, 10.986328125>;
	if(Glyph == "‰") return <541.4189453125, 224, 58.837890625>;
	if(Glyph == "‱") return <549.744140625, 288, 75.48828125>;
	if(Glyph == "′") return <516.7119140625, 352, 9.423828125>;
	if(Glyph == "″") return <521.423828125, 416, 18.84765625>;
	if(Glyph == "‴") return <526.1357421875, 480, 28.271484375>;
	if(Glyph == "‵") return <516.7119140625, 544, 9.423828125>;
	if(Glyph == "‶") return <521.423828125, 608, 18.84765625>;
	if(Glyph == "‷") return <526.1357421875, 672, 28.271484375>;
	if(Glyph == "‸") return <522.44921875, 736, 20.8984375>;
	if(Glyph == "‹") return <520.11767578125, 800, 16.2353515625>;
	if(Glyph == "›") return <520.11767578125, 864, 16.2353515625>;
	if(Glyph == "※") return <526.990234375, 928, 29.98046875>;
	if(Glyph == "‼") return <522.986328125, 992, 21.97265625>;
	if(Glyph == "‽") return <865.6380208333333, -992, 24.609375>;
	if(Glyph == "‾") return <866.0530598958333, -928, 25.439453125>;
	if(Glyph == "‿") return <872.8645833333333, -864, 39.0625>;
	if(Glyph == "⁀") return <872.8645833333333, -800, 39.0625>;
	if(Glyph == "⁁") return <863.7825520833333, -736, 20.8984375>;
	if(Glyph == "⁂") return <870.5940755208333, -672, 34.521484375>;
	if(Glyph == "⁃") return <865.8333333333333, -608, 25>;
	if(Glyph == "⁄") return <856.4827473958333, -544, 6.298828125>;
	if(Glyph == "⁅") return <860.8040364583333, -480, 14.94140625>;
	if(Glyph == "⁆") return <860.8040364583333, -416, 14.94140625>;
	if(Glyph == "⁇") return <879.5296223958333, -352, 52.392578125>;
	if(Glyph == "⁈") return <871.9246419270833, -288, 37.1826171875>;
	if(Glyph == "⁉") return <871.9246419270833, -224, 37.1826171875>;
	if(Glyph == "⁊") return <863.1722005208333, -160, 19.677734375>;
	if(Glyph == "⁋") return <867.3836263020833, -96, 28.1005859375>;
	if(Glyph == "⁌") return <867.3225911458333, -32, 27.978515625>;
	if(Glyph == "⁍") return <867.3225911458333, 32, 27.978515625>;
	if(Glyph == "⁎") return <865.0520833333333, 96, 23.4375>;
	if(Glyph == "⁏") return <858.8997395833333, 160, 11.1328125>;
	if(Glyph == "⁐") return <872.8645833333333, 224, 39.0625>;
	if(Glyph == "⁑") return <866.0530598958333, 288, 25.439453125>;
	if(Glyph == "⁒") return <868.8850911458333, 352, 31.103515625>;
	if(Glyph == "⁓") return <870.5940755208333, 416, 34.521484375>;
	if(Glyph == "⁔") return <872.8645833333333, 480, 39.0625>;
	if(Glyph == "⁕") return <866.0530598958333, 544, 25.439453125>;
	if(Glyph == "⁖") return <867.9329427083333, 608, 29.19921875>;
	if(Glyph == "⁗") return <872.1809895833333, 672, 37.6953125>;
	if(Glyph == "⁘") return <867.9329427083333, 736, 29.19921875>;
	if(Glyph == "⁙") return <867.9329427083333, 800, 29.19921875>;
	if(Glyph == "⁚") return <860.2791341145833, 864, 13.8916015625>;
	if(Glyph == "⁛") return <867.9329427083333, 928, 29.19921875>;
	if(Glyph == "⁜") return <870.5086263020833, 992, 34.3505859375>;
	if(Glyph == "⁝") return <0, 0, 13.8916015625>;
	if(Glyph == "⁞") return <0, 0, 13.8916015625>;
	if(Glyph == " ") return <0, 0, 12.5>;
	if(Glyph == "⁠") return <0, 0, 0>;
	return <0, 0, 0>;
}
*/
// Texture coordinates and letter spacing
vector Glyphs(string Glyph) {
	if(Glyph == "0") return <-923.3346354166666, -992, 30.6640625>;
	if(Glyph == "1") return <-929.6090494791666, -928, 18.115234375>;
	if(Glyph == "2") return <-924.6407877604166, -864, 28.0517578125>;
	if(Glyph == "3") return <-923.7008463541666, -800, 29.931640625>;
	if(Glyph == "4") return <-923.2247721354166, -736, 30.8837890625>;
	if(Glyph == "5") return <-924.2501627604166, -672, 28.8330078125>;
	if(Glyph == "6") return <-924.0670572916666, -608, 29.19921875>;
	if(Glyph == "7") return <-925.7760416666666, -544, 25.78125>;
	if(Glyph == "8") return <-924.1158854166666, -480, 29.1015625>;
	if(Glyph == "9") return <-924.0670572916666, -416, 29.19921875>;
	if(Glyph == "a") return <-925.7272135416666, -352, 25.87890625>;
	if(Glyph == "b") return <-924.5309244791666, -288, 28.271484375>;
	if(Glyph == "c") return <-925.5929361979166, -224, 26.1474609375>;
	if(Glyph == "d") return <-924.5309244791666, -160, 28.271484375>;
	if(Glyph == "e") return <-925.2633463541666, -96, 26.806640625>;
	if(Glyph == "f") return <-931.0128580729166, -32, 15.3076171875>;
	if(Glyph == "g") return <-924.5309244791666, 32, 28.271484375>;
	if(Glyph == "h") return <-924.9947916666666, 96, 27.34375>;
	if(Glyph == "i") return <-933.5152994791666, 160, 10.302734375>;
	if(Glyph == "j") return <-933.5152994791666, 224, 10.302734375>;
	if(Glyph == "k") return <-925.9835611979166, 288, 25.3662109375>;
	if(Glyph == "l") return <-933.5152994791666, 352, 10.302734375>;
	if(Glyph == "m") return <-917.6949869791666, 416, 41.943359375>;
	if(Glyph == "n") return <-924.9947916666666, 480, 27.34375>;
	if(Glyph == "o") return <-924.9459635416666, 544, 27.44140625>;
	if(Glyph == "p") return <-924.5309244791666, 608, 28.271484375>;
	if(Glyph == "q") return <-924.5309244791666, 672, 28.271484375>;
	if(Glyph == "r") return <-930.6100260416666, 736, 16.11328125>;
	if(Glyph == "s") return <-926.8014322916666, 800, 23.73046875>;
	if(Glyph == "t") return <-930.8907877604166, 864, 15.5517578125>;
	if(Glyph == "u") return <-924.9947916666666, 928, 27.34375>;
	if(Glyph == "v") return <-925.8736979166666, 992, 25.5859375>;
	if(Glyph == "w") return <-749.201171875, -992, 37.59765625>;
	if(Glyph == "x") return <-755.3291015625, -928, 25.341796875>;
	if(Glyph == "y") return <-755.20703125, -864, 25.5859375>;
	if(Glyph == "z") return <-756.037109375, -800, 23.92578125>;
	if(Glyph == "A") return <-751.6669921875, -736, 32.666015625>;
	if(Glyph == "B") return <-752.04541015625, -672, 31.9091796875>;
	if(Glyph == "C") return <-749.94580078125, -608, 36.1083984375>;
	if(Glyph == "D") return <-750.763671875, -544, 34.47265625>;
	if(Glyph == "E") return <-753.51025390625, -480, 28.9794921875>;
	if(Glyph == "F") return <-754.14501953125, -416, 27.7099609375>;
	if(Glyph == "G") return <-749.73828125, -352, 36.5234375>;
	if(Glyph == "H") return <-750.2998046875, -288, 35.400390625>;
	if(Glyph == "I") return <-762.189453125, -224, 11.62109375>;
	if(Glyph == "J") return <-754.63330078125, -160, 26.7333984375>;
	if(Glyph == "K") return <-752.14306640625, -96, 31.7138671875>;
	if(Glyph == "L") return <-754.62109375, -32, 26.7578125>;
	if(Glyph == "M") return <-746.564453125, 32, 42.87109375>;
	if(Glyph == "N") return <-750.2509765625, 96, 35.498046875>;
	if(Glyph == "O") return <-749.2744140625, 160, 37.451171875>;
	if(Glyph == "P") return <-752.70458984375, 224, 30.5908203125>;
	if(Glyph == "Q") return <-749.2744140625, 288, 37.451171875>;
	if(Glyph == "R") return <-752.19189453125, 352, 31.6162109375>;
	if(Glyph == "S") return <-752.6435546875, 416, 30.712890625>;
	if(Glyph == "T") return <-752.7412109375, 480, 30.517578125>;
	if(Glyph == "U") return <-750.421875, 544, 35.15625>;
	if(Glyph == "V") return <-751.6669921875, 608, 32.666015625>;
	if(Glyph == "W") return <-744.26953125, 672, 47.4609375>;
	if(Glyph == "X") return <-751.8623046875, 736, 32.275390625>;
	if(Glyph == "Y") return <-751.935546875, 800, 32.12890625>;
	if(Glyph == "Z") return <-752.66796875, 864, 30.6640625>;
	if(Glyph == "!") return <-762.5068359375, 928, 10.986328125>;
	if(Glyph == "\"") return <-757.9169921875, 992, 20.166015625>;
	if(Glyph == "#") return <-582.3430989583334, -992, 29.98046875>;
	if(Glyph == "$") return <-581.9768880208334, -928, 30.712890625>;
	if(Glyph == "%") return <-576.2395833333334, -864, 42.1875>;
	if(Glyph == "&") return <-582.1233723958334, -800, 30.419921875>;
	if(Glyph == "'") return <-590.9856770833334, -736, 12.6953125>;
	if(Glyph == "(") return <-589.8626302083334, -672, 14.94140625>;
	if(Glyph == ")") return <-589.8626302083334, -608, 14.94140625>;
	if(Glyph == "*") return <-585.6145833333334, -544, 23.4375>;
	if(Glyph == "+") return <-581.6350911458334, -480, 31.396484375>;
	if(Glyph == ",") return <-591.8401692708334, -416, 10.986328125>;
	if(Glyph == "-") return <-586.6155598958334, -352, 21.435546875>;
	if(Glyph == ".") return <-591.8401692708334, -288, 10.986328125>;
	if(Glyph == "/") return <-589.2034505208334, -224, 16.259765625>;
	if(Glyph == ":") return <-591.8401692708334, -160, 10.986328125>;
	if(Glyph == ";") return <-591.7669270833334, -96, 11.1328125>;
	if(Glyph == "<") return <-581.6350911458334, -32, 31.396484375>;
	if(Glyph == "=") return <-581.6350911458334, 32, 31.396484375>;
	if(Glyph == ">") return <-581.6350911458334, 96, 31.396484375>;
	if(Glyph == "?") return <-584.2351888020834, 160, 26.1962890625>;
	if(Glyph == "@") return <-572.9925130208334, 224, 48.681640625>;
	if(Glyph == "[") return <-589.8626302083334, 288, 14.94140625>;
	if(Glyph == "\\") return <-589.2034505208334, 352, 16.259765625>;
	if(Glyph == "]") return <-589.8626302083334, 416, 14.94140625>;
	if(Glyph == "^") return <-586.3958333333334, 480, 21.875>;
	if(Glyph == "_") return <-585.9807942708334, 544, 22.705078125>;
	if(Glyph == "{") return <-587.7141927083334, 608, 19.23828125>;
	if(Glyph == "|") return <-589.9358723958334, 672, 14.794921875>;
	if(Glyph == "}") return <-587.7141927083334, 736, 19.23828125>;
	if(Glyph == "~") return <-581.6350911458334, 800, 31.396484375>;
	if(Glyph == "¡") return <-591.6936848958334, 864, 11.279296875>;
	if(Glyph == "¢") return <-584.2596028645834, 928, 26.1474609375>;
	if(Glyph == "£") return <-582.7825520833334, 992, 29.1015625>;
	if(Glyph == "¤") return <-409.38151041666663, -992, 34.5703125>;
	if(Glyph == "¥") return <-413.75162760416663, -928, 25.830078125>;
	if(Glyph == "¦") return <-420.80729166666663, -864, 11.71875>;
	if(Glyph == "§") return <-413.23893229166663, -800, 26.85546875>;
	if(Glyph == "¨") return <-412.99479166666663, -736, 27.34375>;
	if(Glyph == "©") return <-404.59635416666663, -672, 44.140625>;
	if(Glyph == "ª") return <-416.11979166666663, -608, 21.09375>;
	if(Glyph == "«") return <-413.59293619791663, -544, 26.1474609375>;
	if(Glyph == "¬") return <-410.96842447916663, -480, 31.396484375>;
	if(Glyph == "®") return <-410.89518229166663, -416, 31.54296875>;
	if(Glyph == "¯") return <-416.51041666666663, -352, 20.3125>;
	if(Glyph == "°") return <-416.09537760416663, -288, 21.142578125>;
	if(Glyph == "±") return <-410.96842447916663, -224, 31.396484375>;
	if(Glyph == "²") return <-417.03531901041663, -160, 19.2626953125>;
	if(Glyph == "³") return <-416.63248697916663, -96, 20.068359375>;
	if(Glyph == "´") return <-420.63639322916663, -32, 12.060546875>;
	if(Glyph == "µ") return <-412.84830729166663, 32, 27.63671875>;
	if(Glyph == "¶") return <-412.61637369791663, 96, 28.1005859375>;
	if(Glyph == "·") return <-421.17350260416663, 160, 10.986328125>;
	if(Glyph == "¸") return <-420.78287760416663, 224, 11.767578125>;
	if(Glyph == "¹") return <-420.14811197916663, 288, 13.037109375>;
	if(Glyph == "º") return <-415.52164713541663, 352, 22.2900390625>;
	if(Glyph == "»") return <-413.59293619791663, 416, 26.1474609375>;
	if(Glyph == "¼") return <-408.57584635416663, 480, 36.181640625>;
	if(Glyph == "½") return <-407.77018229166663, 544, 37.79296875>;
	if(Glyph == "¾") return <-406.56168619791663, 608, 40.2099609375>;
	if(Glyph == "¿") return <-413.56852213541663, 672, 26.1962890625>;
	if(Glyph == "À") return <-410.33365885416663, 736, 32.666015625>;
	if(Glyph == "Á") return <-410.33365885416663, 800, 32.666015625>;
	if(Glyph == "Â") return <-410.33365885416663, 864, 32.666015625>;
	if(Glyph == "Ã") return <-410.33365885416663, 928, 32.666015625>;
	if(Glyph == "Ä") return <-410.33365885416663, 992, 32.666015625>;
	if(Glyph == "Å") return <-239.6669921875, -992, 32.666015625>;
	if(Glyph == "Æ") return <-231.81787109375, -928, 48.3642578125>;
	if(Glyph == "Ç") return <-237.94580078125, -864, 36.1083984375>;
	if(Glyph == "È") return <-241.51025390625, -800, 28.9794921875>;
	if(Glyph == "É") return <-241.51025390625, -736, 28.9794921875>;
	if(Glyph == "Ê") return <-241.51025390625, -672, 28.9794921875>;
	if(Glyph == "Ë") return <-241.51025390625, -608, 28.9794921875>;
	if(Glyph == "Ì") return <-250.189453125, -544, 11.62109375>;
	if(Glyph == "Í") return <-250.189453125, -480, 11.62109375>;
	if(Glyph == "Î") return <-250.189453125, -416, 11.62109375>;
	if(Glyph == "Ï") return <-250.189453125, -352, 11.62109375>;
	if(Glyph == "Ð") return <-237.92138671875, -288, 36.1572265625>;
	if(Glyph == "Ñ") return <-238.2509765625, -224, 35.498046875>;
	if(Glyph == "Ò") return <-237.2744140625, -160, 37.451171875>;
	if(Glyph == "Ó") return <-237.2744140625, -96, 37.451171875>;
	if(Glyph == "Ô") return <-237.2744140625, -32, 37.451171875>;
	if(Glyph == "Õ") return <-237.2744140625, 32, 37.451171875>;
	if(Glyph == "Ö") return <-237.2744140625, 96, 37.451171875>;
	if(Glyph == "×") return <-240.3017578125, 160, 31.396484375>;
	if(Glyph == "Ø") return <-237.2744140625, 224, 37.451171875>;
	if(Glyph == "Ù") return <-238.421875, 288, 35.15625>;
	if(Glyph == "Ú") return <-238.421875, 352, 35.15625>;
	if(Glyph == "Û") return <-238.421875, 416, 35.15625>;
	if(Glyph == "Ü") return <-238.421875, 480, 35.15625>;
	if(Glyph == "Ý") return <-239.935546875, 544, 32.12890625>;
	if(Glyph == "Þ") return <-241.009765625, 608, 29.98046875>;
	if(Glyph == "ß") return <-241.595703125, 672, 28.80859375>;
	if(Glyph == "à") return <-243.060546875, 736, 25.87890625>;
	if(Glyph == "á") return <-243.060546875, 800, 25.87890625>;
	if(Glyph == "â") return <-243.060546875, 864, 25.87890625>;
	if(Glyph == "ã") return <-243.060546875, 928, 25.87890625>;
	if(Glyph == "ä") return <-243.060546875, 992, 25.87890625>;
	if(Glyph == "å") return <-72.39388020833337, -992, 25.87890625>;
	if(Glyph == "æ") return <-63.54378255208337, -928, 43.5791015625>;
	if(Glyph == "ç") return <-72.25960286458337, -864, 26.1474609375>;
	if(Glyph == "è") return <-71.93001302083337, -800, 26.806640625>;
	if(Glyph == "é") return <-71.93001302083337, -736, 26.806640625>;
	if(Glyph == "ê") return <-71.93001302083337, -672, 26.806640625>;
	if(Glyph == "ë") return <-71.93001302083337, -608, 26.806640625>;
	if(Glyph == "ì") return <-80.18196614583337, -544, 10.302734375>;
	if(Glyph == "í") return <-80.18196614583337, -480, 10.302734375>;
	if(Glyph == "î") return <-80.18196614583337, -416, 10.302734375>;
	if(Glyph == "ï") return <-80.18196614583337, -352, 10.302734375>;
	if(Glyph == "ð") return <-71.63704427083337, -288, 27.392578125>;
	if(Glyph == "ñ") return <-71.66145833333337, -224, 27.34375>;
	if(Glyph == "ò") return <-71.61263020833337, -160, 27.44140625>;
	if(Glyph == "ó") return <-71.61263020833337, -96, 27.44140625>;
	if(Glyph == "ô") return <-71.61263020833337, -32, 27.44140625>;
	if(Glyph == "õ") return <-71.61263020833337, 32, 27.44140625>;
	if(Glyph == "ö") return <-71.61263020833337, 96, 27.44140625>;
	if(Glyph == "÷") return <-69.63509114583337, 160, 31.396484375>;
	if(Glyph == "ø") return <-71.61263020833337, 224, 27.44140625>;
	if(Glyph == "ù") return <-71.66145833333337, 288, 27.34375>;
	if(Glyph == "ú") return <-71.66145833333337, 352, 27.34375>;
	if(Glyph == "û") return <-71.66145833333337, 416, 27.34375>;
	if(Glyph == "ü") return <-71.66145833333337, 480, 27.34375>;
	if(Glyph == "ý") return <-72.54036458333337, 544, 25.5859375>;
	if(Glyph == "þ") return <-71.19759114583337, 608, 28.271484375>;
	if(Glyph == "ÿ") return <-72.54036458333337, 672, 25.5859375>;
	if(Glyph == "‐") return <-77.15462239583337, 736, 16.357421875>;
	if(Glyph == "‑") return <-77.15462239583337, 800, 16.357421875>;
	if(Glyph == "‒") return <-69.22005208333337, 864, 32.2265625>;
	if(Glyph == "–") return <-72.83333333333337, 928, 25>;
	if(Glyph == "—") return <-60.33333333333337, 992, 50>;
	if(Glyph == "―") return <110.33333333333326, -992, 50>;
	if(Glyph == "‖") return <96.39290364583326, -928, 22.119140625>;
	if(Glyph == "‗") return <95.85579427083326, -864, 21.044921875>;
	if(Glyph == "‘") return <90.09407552083326, -800, 9.521484375>;
	if(Glyph == "’") return <90.09407552083326, -736, 9.521484375>;
	if(Glyph == "‚") return <89.72786458333326, -672, 8.7890625>;
	if(Glyph == "‛") return <90.09407552083326, -608, 9.521484375>;
	if(Glyph == "“") return <93.80501302083326, -544, 16.943359375>;
	if(Glyph == "”") return <93.82942708333326, -480, 16.9921875>;
	if(Glyph == "„") return <93.46321614583326, -416, 16.259765625>;
	if(Glyph == "‟") return <93.82942708333326, -352, 16.9921875>;
	if(Glyph == "†") return <96.73470052083326, -288, 22.802734375>;
	if(Glyph == "‡") return <96.73470052083326, -224, 22.802734375>;
	if(Glyph == "•") return <97.83333333333326, -160, 25>;
	if(Glyph == "‣") return <97.83333333333326, -96, 25>;
	if(Glyph == "․") return <90.82649739583326, -32, 10.986328125>;
	if(Glyph == "‥") return <96.31966145833326, 32, 21.97265625>;
	if(Glyph == "…") return <101.81282552083326, 96, 32.958984375>;
	if(Glyph == "‧") return <90.82649739583326, 160, 10.986328125>;
	if(Glyph == "‰") return <114.75227864583326, 224, 58.837890625>;
	if(Glyph == "‱") return <123.07747395833326, 288, 75.48828125>;
	if(Glyph == "′") return <90.04524739583326, 352, 9.423828125>;
	if(Glyph == "″") return <94.75716145833326, 416, 18.84765625>;
	if(Glyph == "‴") return <99.46907552083326, 480, 28.271484375>;
	if(Glyph == "‵") return <90.04524739583326, 544, 9.423828125>;
	if(Glyph == "‶") return <94.75716145833326, 608, 18.84765625>;
	if(Glyph == "‷") return <99.46907552083326, 672, 28.271484375>;
	if(Glyph == "‸") return <95.78255208333326, 736, 20.8984375>;
	if(Glyph == "‹") return <93.45100911458326, 800, 16.2353515625>;
	if(Glyph == "›") return <93.45100911458326, 864, 16.2353515625>;
	if(Glyph == "‽") return <97.63802083333326, 928, 24.609375>;
	if(Glyph == "Ā") return <101.66634114583326, 992, 32.666015625>;
	if(Glyph == "ā") return <268.9394531249998, -992, 25.87890625>;
	if(Glyph == "Ă") return <272.3330078124998, -928, 32.666015625>;
	if(Glyph == "ă") return <268.9394531249998, -864, 25.87890625>;
	if(Glyph == "Ą") return <272.3330078124998, -800, 32.666015625>;
	if(Glyph == "ą") return <268.9394531249998, -736, 25.87890625>;
	if(Glyph == "Ć") return <274.0541992187498, -672, 36.1083984375>;
	if(Glyph == "ć") return <269.0737304687498, -608, 26.1474609375>;
	if(Glyph == "Ĉ") return <274.0541992187498, -544, 36.1083984375>;
	if(Glyph == "ĉ") return <269.0737304687498, -480, 26.1474609375>;
	if(Glyph == "Ċ") return <274.0541992187498, -416, 36.1083984375>;
	if(Glyph == "ċ") return <269.0737304687498, -352, 26.1474609375>;
	if(Glyph == "Č") return <274.0541992187498, -288, 36.1083984375>;
	if(Glyph == "č") return <269.0737304687498, -224, 26.1474609375>;
	if(Glyph == "Ď") return <273.2363281249998, -160, 34.47265625>;
	if(Glyph == "ď") return <272.5771484374998, -96, 33.154296875>;
	if(Glyph == "Đ") return <274.0786132812498, -32, 36.1572265625>;
	if(Glyph == "đ") return <270.1357421874998, 32, 28.271484375>;
	if(Glyph == "Ē") return <270.4897460937498, 96, 28.9794921875>;
	if(Glyph == "ē") return <269.4033203124998, 160, 26.806640625>;
	if(Glyph == "Ĕ") return <270.4897460937498, 224, 28.9794921875>;
	if(Glyph == "ĕ") return <269.4033203124998, 288, 26.806640625>;
	if(Glyph == "Ė") return <270.4897460937498, 352, 28.9794921875>;
	if(Glyph == "ė") return <269.4033203124998, 416, 26.806640625>;
	if(Glyph == "Ę") return <270.4897460937498, 480, 28.9794921875>;
	if(Glyph == "ę") return <269.4033203124998, 544, 26.806640625>;
	if(Glyph == "Ě") return <270.4897460937498, 608, 28.9794921875>;
	if(Glyph == "ě") return <269.4033203124998, 672, 26.806640625>;
	if(Glyph == "Ĝ") return <274.2617187499998, 736, 36.5234375>;
	if(Glyph == "ĝ") return <270.1357421874998, 800, 28.271484375>;
	if(Glyph == "Ğ") return <274.2617187499998, 864, 36.5234375>;
	if(Glyph == "ğ") return <270.1357421874998, 928, 28.271484375>;
	if(Glyph == "Ġ") return <274.2617187499998, 992, 36.5234375>;
	if(Glyph == "ġ") return <440.8024088541665, -992, 28.271484375>;
	if(Glyph == "Ģ") return <444.9283854166665, -928, 36.5234375>;
	if(Glyph == "ģ") return <440.8024088541665, -864, 28.271484375>;
	if(Glyph == "Ĥ") return <444.3668619791665, -800, 35.400390625>;
	if(Glyph == "ĥ") return <440.3385416666665, -736, 27.34375>;
	if(Glyph == "Ħ") return <444.9039713541665, -672, 36.474609375>;
	if(Glyph == "ħ") return <440.3385416666665, -608, 27.34375>;
	if(Glyph == "Ĩ") return <432.4772135416665, -544, 11.62109375>;
	if(Glyph == "ĩ") return <431.8180338541665, -480, 10.302734375>;
	if(Glyph == "Ī") return <432.4772135416665, -416, 11.62109375>;
	if(Glyph == "ī") return <431.8180338541665, -352, 10.302734375>;
	if(Glyph == "Ĭ") return <432.4772135416665, -288, 11.62109375>;
	if(Glyph == "ĭ") return <431.8180338541665, -224, 10.302734375>;
	if(Glyph == "Į") return <432.4772135416665, -160, 11.62109375>;
	if(Glyph == "į") return <431.8180338541665, -96, 10.302734375>;
	if(Glyph == "İ") return <432.4772135416665, -32, 11.62109375>;
	if(Glyph == "ı") return <431.8180338541665, 32, 10.302734375>;
	if(Glyph == "Ĳ") return <445.8439127604165, 96, 38.3544921875>;
	if(Glyph == "ĳ") return <436.9694010416665, 160, 20.60546875>;
	if(Glyph == "Ĵ") return <440.0333658854165, 224, 26.7333984375>;
	if(Glyph == "ĵ") return <431.8180338541665, 288, 10.302734375>;
	if(Glyph == "Ķ") return <442.5236002604165, 352, 31.7138671875>;
	if(Glyph == "ķ") return <439.3497721354165, 416, 25.3662109375>;
	if(Glyph == "ĸ") return <438.8370768229165, 480, 24.3408203125>;
	if(Glyph == "Ĺ") return <440.0455729166665, 544, 26.7578125>;
	if(Glyph == "ĺ") return <431.8180338541665, 608, 10.302734375>;
	if(Glyph == "Ļ") return <440.0455729166665, 672, 26.7578125>;
	if(Glyph == "ļ") return <431.8180338541665, 736, 10.302734375>;
	if(Glyph == "Ľ") return <440.0455729166665, 800, 26.7578125>;
	if(Glyph == "ľ") return <434.2594401041665, 864, 15.185546875>;
	if(Glyph == "Ŀ") return <439.9479166666665, 928, 26.5625>;
	if(Glyph == "ŀ") return <434.8697916666665, 992, 16.40625>;
	if(Glyph == "Ł") return <611.4446614583333, -992, 28.22265625>;
	if(Glyph == "ł") return <602.4847005208333, -928, 10.302734375>;
	if(Glyph == "Ń") return <615.0823567708333, -864, 35.498046875>;
	if(Glyph == "ń") return <611.0052083333333, -800, 27.34375>;
	if(Glyph == "Ņ") return <615.0823567708333, -736, 35.498046875>;
	if(Glyph == "ņ") return <611.0052083333333, -672, 27.34375>;
	if(Glyph == "Ň") return <615.0823567708333, -608, 35.498046875>;
	if(Glyph == "ň") return <611.0052083333333, -544, 27.34375>;
	if(Glyph == "ŉ") return <611.2371419270833, -480, 27.8076171875>;
	if(Glyph == "Ŋ") return <615.0823567708333, -416, 35.498046875>;
	if(Glyph == "ŋ") return <611.0052083333333, -352, 27.34375>;
	if(Glyph == "Ō") return <616.0589192708333, -288, 37.451171875>;
	if(Glyph == "ō") return <611.0540364583333, -224, 27.44140625>;
	if(Glyph == "Ŏ") return <616.0589192708333, -160, 37.451171875>;
	if(Glyph == "ŏ") return <611.0540364583333, -96, 27.44140625>;
	if(Glyph == "Ő") return <616.0589192708333, -32, 37.451171875>;
	if(Glyph == "ő") return <611.0540364583333, 32, 27.44140625>;
	if(Glyph == "Œ") return <622.0281575520833, 96, 49.3896484375>;
	if(Glyph == "œ") return <620.6365559895833, 160, 46.6064453125>;
	if(Glyph == "Ŕ") return <613.1414388020833, 224, 31.6162109375>;
	if(Glyph == "ŕ") return <605.3899739583333, 288, 16.11328125>;
	if(Glyph == "Ŗ") return <613.1414388020833, 352, 31.6162109375>;
	if(Glyph == "ŗ") return <605.3899739583333, 416, 16.11328125>;
	if(Glyph == "Ř") return <613.1414388020833, 480, 31.6162109375>;
	if(Glyph == "ř") return <605.3899739583333, 544, 16.11328125>;
	if(Glyph == "Ś") return <612.6897786458333, 608, 30.712890625>;
	if(Glyph == "ś") return <609.1985677083333, 672, 23.73046875>;
	if(Glyph == "Ŝ") return <612.6897786458333, 736, 30.712890625>;
	if(Glyph == "ŝ") return <609.1985677083333, 800, 23.73046875>;
	if(Glyph == "Ş") return <612.6897786458333, 864, 30.712890625>;
	if(Glyph == "ş") return <609.1985677083333, 928, 23.73046875>;
	if(Glyph == "Š") return <612.6897786458333, 992, 30.712890625>;
	if(Glyph == "š") return <779.8652343749998, -992, 23.73046875>;
	if(Glyph == "Ţ") return <783.2587890624998, -928, 30.517578125>;
	if(Glyph == "ţ") return <775.7758789062498, -864, 15.5517578125>;
	if(Glyph == "Ť") return <783.2587890624998, -800, 30.517578125>;
	if(Glyph == "ť") return <776.9965820312498, -736, 17.9931640625>;
	if(Glyph == "Ŧ") return <783.2587890624998, -672, 30.517578125>;
	if(Glyph == "ŧ") return <775.7758789062498, -608, 15.5517578125>;
	if(Glyph == "Ũ") return <785.5781249999998, -544, 35.15625>;
	if(Glyph == "ũ") return <781.6718749999998, -480, 27.34375>;
	if(Glyph == "Ū") return <785.5781249999998, -416, 35.15625>;
	if(Glyph == "ū") return <781.6718749999998, -352, 27.34375>;
	if(Glyph == "Ŭ") return <785.5781249999998, -288, 35.15625>;
	if(Glyph == "ŭ") return <781.6718749999998, -224, 27.34375>;
	if(Glyph == "Ů") return <785.5781249999998, -160, 35.15625>;
	if(Glyph == "ů") return <781.6718749999998, -96, 27.34375>;
	if(Glyph == "Ű") return <785.5781249999998, -32, 35.15625>;
	if(Glyph == "ű") return <781.6718749999998, 32, 27.34375>;
	if(Glyph == "Ų") return <785.5781249999998, 96, 35.15625>;
	if(Glyph == "ų") return <781.6718749999998, 160, 27.34375>;
	if(Glyph == "Ŵ") return <791.7304687499998, 224, 47.4609375>;
	if(Glyph == "ŵ") return <786.7988281249998, 288, 37.59765625>;
	if(Glyph == "Ŷ") return <784.0644531249998, 352, 32.12890625>;
	if(Glyph == "ŷ") return <780.7929687499998, 416, 25.5859375>;
	if(Glyph == "Ÿ") return <784.0644531249998, 480, 32.12890625>;
	if(Glyph == "Ź") return <783.3320312499998, 544, 30.6640625>;
	if(Glyph == "ź") return <779.9628906249998, 608, 23.92578125>;
	if(Glyph == "Ż") return <783.3320312499998, 672, 30.6640625>;
	if(Glyph == "ż") return <779.9628906249998, 736, 23.92578125>;
	if(Glyph == "Ž") return <783.3320312499998, 800, 30.6640625>;
	if(Glyph == "ž") return <779.9628906249998, 864, 23.92578125>;
	if(Glyph == "ſ") return <774.2377929687498, 928, 12.4755859375>;
	if(Glyph == "ƀ") return <782.1357421874998, 992, 28.271484375>;
	if(Glyph == "Ɓ") return <958.0392252604165, -992, 38.7451171875>;
	if(Glyph == "Ƃ") return <954.2184244791665, -928, 31.103515625>;
	if(Glyph == "ƃ") return <952.8024088541665, -864, 28.271484375>;
	if(Glyph == "Ƅ") return <956.9894205729165, -800, 36.6455078125>;
	if(Glyph == "ƅ") return <954.3527018229165, -736, 31.3720703125>;
	if(Glyph == "Ɔ") return <956.7208658854165, -672, 36.1083984375>;
	if(Glyph == "Ƈ") return <956.7208658854165, -608, 36.1083984375>;
	if(Glyph == "ƈ") return <954.2306315104165, -544, 31.1279296875>;
	if(Glyph == "Ɖ") return <956.7452799479165, -480, 36.1572265625>;
	if(Glyph == "Ɗ") return <959.3209635416665, -416, 41.30859375>;
	if(Glyph == "Ƌ") return <953.6569010416665, -352, 29.98046875>;
	if(Glyph == "ƌ") return <952.8024088541665, -288, 28.271484375>;
	if(Glyph == "ƍ") return <951.3863932291665, -224, 25.439453125>;
	if(Glyph == "Ǝ") return <953.1564127604165, -160, 28.9794921875>;
	if(Glyph == "Ə") return <956.9283854166665, -96, 36.5234375>;
	if(Glyph == "Ɛ") return <953.6324869791665, -32, 29.931640625>;
	if(Glyph == "Ƒ") return <952.5216471354165, 32, 27.7099609375>;
	if(Glyph == "ƒ") return <947.5533854166665, 96, 17.7734375>;
	if(Glyph == "Ɠ") return <956.9283854166665, 160, 36.5234375>;
	if(Glyph == "Ɣ") return <953.6569010416665, 224, 29.98046875>;
	if(Glyph == "ƕ") return <961.4205729166665, 288, 45.5078125>;
	if(Glyph == "Ɩ") return <944.4039713541665, 352, 11.474609375>;
	if(Glyph == "Ɨ") return <946.4303385416665, 416, 15.52734375>;
	if(Glyph == "Ƙ") return <954.6822916666665, 480, 32.03125>;
	if(Glyph == "ƙ") return <951.3497721354165, 544, 25.3662109375>;
	if(Glyph == "ƚ") return <943.8180338541665, 608, 10.302734375>;
	if(Glyph == "ƛ") return <953.0953776041665, 672, 28.857421875>;
	if(Glyph == "Ɯ") return <960.4684244791665, 736, 43.603515625>;
	if(Glyph == "Ɲ") return <956.4156901041665, 800, 35.498046875>;
	if(Glyph == "ƞ") return <952.3385416666665, 864, 27.34375>;
	if(Glyph == "Ɵ") return <957.3922526041665, 928, 37.451171875>;
	if(Glyph == "Ơ") return <957.3922526041665, 992, 37.451171875>;
	return <0, 0, 0>;
}

// Initializes the system by checking for Text prims and resetting them
textInit()
{
    list params;
    integer cutoff = llRound(220. + ((64. - 220.) * ((100. - FontWeight) / (100. - 900.))));
    integer Prims = llGetNumberOfPrims() + 1;
    while(--Prims)
    {
        if(llGetLinkName(Prims) == "Text")
        {
            Free += Prims;
            params += [
                PRIM_LINK_TARGET, Prims,
                PRIM_POS_LOCAL, <0,0,0>,
                PRIM_ROT_LOCAL, <.5,.5,.5,.5>,
                PRIM_SIZE, <.01,.01,.01>,
                PRIM_COLOR, ALL_SIDES, Color, 1,
                PRIM_TEXTURE, ALL_SIDES, TEXTURE_INTER, ZERO_VECTOR, ZERO_VECTOR, 0.0,
                PRIM_ALPHA_MODE, ALL_SIDES, PRIM_ALPHA_MODE_MASK, cutoff
            ];
            if(!(Prims%32))
            {
                llSetLinkPrimitiveParamsFast(0, params);
                params = [];
            }
        }
    }
    
    llSetLinkPrimitiveParamsFast(0, params);
}

// Function to check if a string can be rendered or not, e.g. a display name
textCanBeRendered(string text)
{
    integer count = llStringLength(text);
    while(count --> 0)
    {
        string letter = llGetSubString(text, count, count);
        if(letter == " ");; // Space
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
        else if(Glyphs(char) == ZERO_VECTOR) return FALSE;
    }
    return TRUE;
}




