#define TEXTURE_INTER "3358996a-7acb-9e5c-202c-6ad915155ad1"
#define TEXTURE_EIGHT "876a12ca-928e-baf1-a35b-f3aab5db95bc"
#define TEXTURE_SIZE 2048.
#define CELL_SIZE 64.
#define WHITESPACE_WIDTH 12.5
#define WIDEST_WIDTH 48.681640625
#define COLUMNS 5
#define COLUMN_WIDTH 409.6


vector Glyphs(string Glyph)
{
    if(Glyph == "0") return <-803.86796875, -992, 30.6640625>;
    if(Glyph == "1") return <-810.1423828125, -928, 18.115234375>;
    if(Glyph == "2") return <-805.17412109375, -864, 28.0517578125>;
    if(Glyph == "3") return <-804.2341796875, -800, 29.931640625>;
    if(Glyph == "4") return <-803.75810546875, -736, 30.8837890625>;
    if(Glyph == "5") return <-804.78349609375, -672, 28.8330078125>;
    if(Glyph == "6") return <-804.600390625, -608, 29.19921875>;
    if(Glyph == "7") return <-806.309375, -544, 25.78125>;
    if(Glyph == "8") return <-804.64921875, -480, 29.1015625>;
    if(Glyph == "9") return <-804.600390625, -416, 29.19921875>;
    if(Glyph == "a") return <-806.260546875, -352, 25.87890625>;
    if(Glyph == "b") return <-805.0642578125, -288, 28.271484375>;
    if(Glyph == "c") return <-806.12626953125, -224, 26.1474609375>;
    if(Glyph == "d") return <-805.0642578125, -160, 28.271484375>;
    if(Glyph == "e") return <-805.7966796875, -96, 26.806640625>;
    if(Glyph == "f") return <-811.54619140625, -32, 15.3076171875>;
    if(Glyph == "g") return <-805.0642578125, 32, 28.271484375>;
    if(Glyph == "h") return <-805.528125, 96, 27.34375>;
    if(Glyph == "i") return <-814.0486328125, 160, 10.302734375>;
    if(Glyph == "j") return <-814.0486328125, 224, 10.302734375>;
    if(Glyph == "k") return <-806.51689453125, 288, 25.3662109375>;
    if(Glyph == "l") return <-814.0486328125, 352, 10.302734375>;
    if(Glyph == "m") return <-798.2283203125, 416, 41.943359375>;
    if(Glyph == "n") return <-805.528125, 480, 27.34375>;
    if(Glyph == "o") return <-805.479296875, 544, 27.44140625>;
    if(Glyph == "p") return <-805.0642578125, 608, 28.271484375>;
    if(Glyph == "q") return <-805.0642578125, 672, 28.271484375>;
    if(Glyph == "r") return <-811.143359375, 736, 16.11328125>;
    if(Glyph == "s") return <-807.334765625, 800, 23.73046875>;
    if(Glyph == "t") return <-811.42412109375, 864, 15.5517578125>;
    if(Glyph == "u") return <-805.528125, 928, 27.34375>;
    if(Glyph == "v") return <-806.40703125, 992, 25.5859375>;
    if(Glyph == "w") return <-390.8011718749999, -992, 37.59765625>;
    if(Glyph == "x") return <-396.9291015624999, -928, 25.341796875>;
    if(Glyph == "y") return <-396.8070312499999, -864, 25.5859375>;
    if(Glyph == "z") return <-397.6371093749999, -800, 23.92578125>;
    if(Glyph == "A") return <-393.2669921874999, -736, 32.666015625>;
    if(Glyph == "B") return <-393.6454101562499, -672, 31.9091796875>;
    if(Glyph == "C") return <-391.5458007812499, -608, 36.1083984375>;
    if(Glyph == "D") return <-392.3636718749999, -544, 34.47265625>;
    if(Glyph == "E") return <-395.1102539062499, -480, 28.9794921875>;
    if(Glyph == "F") return <-395.7450195312499, -416, 27.7099609375>;
    if(Glyph == "G") return <-391.3382812499999, -352, 36.5234375>;
    if(Glyph == "H") return <-391.8998046874999, -288, 35.400390625>;
    if(Glyph == "I") return <-403.7894531249999, -224, 11.62109375>;
    if(Glyph == "J") return <-396.2333007812499, -160, 26.7333984375>;
    if(Glyph == "K") return <-393.7430664062499, -96, 31.7138671875>;
    if(Glyph == "L") return <-396.2210937499999, -32, 26.7578125>;
    if(Glyph == "M") return <-388.1644531249999, 32, 42.87109375>;
    if(Glyph == "N") return <-391.8509765624999, 96, 35.498046875>;
    if(Glyph == "O") return <-390.8744140624999, 160, 37.451171875>;
    if(Glyph == "P") return <-394.3045898437499, 224, 30.5908203125>;
    if(Glyph == "Q") return <-390.8744140624999, 288, 37.451171875>;
    if(Glyph == "R") return <-393.7918945312499, 352, 31.6162109375>;
    if(Glyph == "S") return <-394.2435546874999, 416, 30.712890625>;
    if(Glyph == "T") return <-394.3412109374999, 480, 30.517578125>;
    if(Glyph == "U") return <-392.0218749999999, 544, 35.15625>;
    if(Glyph == "V") return <-393.2669921874999, 608, 32.666015625>;
    if(Glyph == "W") return <-385.8695312499999, 672, 47.4609375>;
    if(Glyph == "X") return <-393.4623046874999, 736, 32.275390625>;
    if(Glyph == "Y") return <-393.5355468749999, 800, 32.12890625>;
    if(Glyph == "Z") return <-394.2679687499999, 864, 30.6640625>;
    if(Glyph == "!") return <-404.1068359374999, 928, 10.986328125>;
    if(Glyph == "\"") return <-399.5169921874999, 992, 20.166015625>;
    if(Glyph == "#") return <14.990234375, -992, 29.98046875>;
    if(Glyph == "$") return <15.3564453125, -928, 30.712890625>;
    if(Glyph == "%") return <21.09375, -864, 42.1875>;
    if(Glyph == "&") return <15.2099609375, -800, 30.419921875>;
    if(Glyph == "'") return <6.34765625, -736, 12.6953125>;
    if(Glyph == "(") return <7.470703125, -672, 14.94140625>;
    if(Glyph == ")") return <7.470703125, -608, 14.94140625>;
    if(Glyph == "*") return <11.71875, -544, 23.4375>;
    if(Glyph == "+") return <15.6982421875, -480, 31.396484375>;
    if(Glyph == ",") return <5.4931640625, -416, 10.986328125>;
    if(Glyph == "-") return <10.7177734375, -352, 21.435546875>;
    if(Glyph == ".") return <5.4931640625, -288, 10.986328125>;
    if(Glyph == "/") return <8.1298828125, -224, 16.259765625>;
    if(Glyph == ":") return <5.4931640625, -160, 10.986328125>;
    if(Glyph == ";") return <5.56640625, -96, 11.1328125>;
    if(Glyph == "<") return <15.6982421875, -32, 31.396484375>;
    if(Glyph == "=") return <15.6982421875, 32, 31.396484375>;
    if(Glyph == ">") return <15.6982421875, 96, 31.396484375>;
    if(Glyph == "?") return <13.09814453125, 160, 26.1962890625>;
    if(Glyph == "@") return <24.3408203125, 224, 48.681640625>;
    if(Glyph == "[") return <7.470703125, 288, 14.94140625>;
    if(Glyph == "\\") return <8.1298828125, 352, 16.259765625>;
    if(Glyph == "]") return <7.470703125, 416, 14.94140625>;
    if(Glyph == "^") return <10.9375, 480, 21.875>;
    if(Glyph == "_") return <11.3525390625, 544, 22.705078125>;
    if(Glyph == "{") return <9.619140625, 608, 19.23828125>;
    if(Glyph == "|") return <7.3974609375, 672, 14.794921875>;
    if(Glyph == "}") return <9.619140625, 736, 19.23828125>;
    if(Glyph == "~") return <15.6982421875, 800, 31.396484375>;
    if(Glyph == "¡") return <5.6396484375, 864, 11.279296875>;
    if(Glyph == "¢") return <13.07373046875, 928, 26.1474609375>;
    if(Glyph == "£") return <14.55078125, 992, 29.1015625>;
    if(Glyph == "¤") return <426.88515625000014, -992, 34.5703125>;
    if(Glyph == "¥") return <422.51503906250014, -928, 25.830078125>;
    if(Glyph == "¦") return <415.45937500000014, -864, 11.71875>;
    if(Glyph == "§") return <423.02773437500014, -800, 26.85546875>;
    if(Glyph == "¨") return <423.27187500000014, -736, 27.34375>;
    if(Glyph == "©") return <431.67031250000014, -672, 44.140625>;
    if(Glyph == "ª") return <420.14687500000014, -608, 21.09375>;
    if(Glyph == "«") return <422.67373046875014, -544, 26.1474609375>;
    if(Glyph == "¬") return <425.29824218750014, -480, 31.396484375>;
    if(Glyph == "®") return <425.37148437500014, -416, 31.54296875>;
    if(Glyph == "¯") return <419.75625000000014, -352, 20.3125>;
    if(Glyph == "°") return <420.17128906250014, -288, 21.142578125>;
    if(Glyph == "±") return <425.29824218750014, -224, 31.396484375>;
    if(Glyph == "²") return <419.23134765625014, -160, 19.2626953125>;
    if(Glyph == "³") return <419.63417968750014, -96, 20.068359375>;
    if(Glyph == "´") return <415.63027343750014, -32, 12.060546875>;
    if(Glyph == "µ") return <423.41835937500014, 32, 27.63671875>;
    if(Glyph == "¶") return <423.65029296875014, 96, 28.1005859375>;
    if(Glyph == "·") return <415.09316406250014, 160, 10.986328125>;
    if(Glyph == "¸") return <415.48378906250014, 224, 11.767578125>;
    if(Glyph == "¹") return <416.11855468750014, 288, 13.037109375>;
    if(Glyph == "º") return <420.74501953125014, 352, 22.2900390625>;
    if(Glyph == "»") return <422.67373046875014, 416, 26.1474609375>;
    if(Glyph == "¼") return <427.69082031250014, 480, 36.181640625>;
    if(Glyph == "½") return <428.49648437500014, 544, 37.79296875>;
    if(Glyph == "¾") return <429.70498046875014, 608, 40.2099609375>;
    if(Glyph == "¿") return <422.69814453125014, 672, 26.1962890625>;
    return ZERO_VECTOR;
}


// Resource management
list Free;
list Used;
list Params;
integer facesLeft;
vector offset;
integer linkTarget;
list queue;

// Positioning
vector Anchor;
rotation Direction;

// Styling
vector FontColor = <1,1,1>;
float FontSize = 0.64;
float LineHeight = 1.2;
integer MaskCutoff = 127;

// Overflow
float TextClipLength = 64.0;
float TextWrapLength = 64.0;





// Initializes the system by checking for Text prims and resetting them
textInit()
{
    integer Prims = llGetNumberOfPrims() + 1;
    while(--Prims)
        if(llGetLinkName(Prims) == "Text")
        {
            Free += Prims;
            Params += [
                PRIM_LINK_TARGET, Prims,
                PRIM_POS_LOCAL, <0,0,0>,
                PRIM_ROT_LOCAL, <.5,.5,.5,.5>,
                PRIM_SIZE, <.01,.01,.01>,
                PRIM_COLOR, ALL_SIDES, FontColor, 1,
                PRIM_TEXTURE, ALL_SIDES, TEXTURE_INTER, ZERO_VECTOR, ZERO_VECTOR, 0.0,
                PRIM_ALPHA_MODE, ALL_SIDES, PRIM_ALPHA_MODE_MASK, MaskCutoff
            ];
            if(!(Prims%32)) textRender();
        }
    textRender();
}

// Depending how much you draw, make sure to flush the render so you don't stack heap
textRender()
{
    llSetLinkPrimitiveParamsFast(0, Params);
    Params = [];
    facesLeft = 0;
}


textOrigin(vector newAnchor)
{
    Anchor = newAnchor;
    facesLeft = 0;
    offset = <0, 0, FontSize * LineHeight * -0.5>;
}

textFontWeight(integer weight)
{
    MaskCutoff = llRound(22. + ((64. - 220.) * ((100. - weight) / (100. - 900.))));
}


// Main function, draw some text!
list text(string str)
{
    list renders = [/*integer linkTarget, integer faces, vector offset<textWidth, y, z>*/];
    list glyphs = [/*vector glyph*/];
    integer index; integer total;
    for(total = llStringLength(str); index < total; ++index)
    {
        string letter = llGetSubString(str, index, index);
        
        // if(letter == "\n")
        // {
        //     // integer linkTarget = llList2Integer(Free, 0);
        //     // Free = llDeleteSubList(Free, 0, 0);
        //     // Used += linkTarget;
        //     // if(renders) renders += [8, offset];
        //     // renders += [linkTarget];
        //     // facesLeft = 8;
            
        //     facesLeft = 0;
        //     offset.y = 0;
        //     offset.z -= FontSize * LineHeight;
            
        //     // tOrigin(Anchor - <0,0,FontSize * LineHeight>);
        // }
        if(letter == "\n") forceLineBreak = TRUE;
        else if(letter == " ") offset.x += WHITESPACE_WIDTH;
        else
        {
            // if((offset.x/CELL_SIZE) * FontSize > TextClipLength); // consume clipped text
            // else
            // {
                vector glyph = Glyphs(letter);
                if(forceLineBreak || !facesLeft || (offset.x + glyph.z >= COLUMN_WIDTH))
                {
                    // Consume prim
                    integer linkTarget = llList2Integer(Free, 0);
                    Free = llDeleteSubList(Free, 0, 0);
                    Used += linkTarget;
                    if(renders) renders += [8, offset];
                    renders += [linkTarget];
                    facesLeft = 8;
                    
                    if(forceLineBreak) // || (offset.x + glyph.z) / CELL_SIZE * FontSize > TextWrapLength)
                    {
                        // Onto a newline
                        offset.y = 0;
                        offset.z -= FontSize * LineHeight;
                        forceLineBreak = FALSE;
                    }
                    else
                    {
                        // Just a split
                        offset.y = offset.x / CELL_SIZE * FontSize;
                        offset.x = 0;
                    }
                }
                
                glyphs += <glyph.x - glyph.z/2, glyph.y, offset.x>;
                offset.x += glyph.z;
                facesLeft--;
            // }
        }
    }
    
    list data;
    
    if(renders)
    {
        renders += [8 - facesLeft, offset];
        facesLeft = 0;
        offset = <0, 0, FontSize * -0.5>;
        data += [Anchor.x, Anchor.y, Anchor.z];
    }
    
    while(renders)
    {
        integer linkTarget = llList2Integer(renders, 0);
        integer faces = llList2Integer(renders, 1);
        vector off = llList2Vector(renders, 2);
        
        Params += [PRIM_LINK_TARGET, linkTarget];
        
        vector repeats = <off.x / TEXTURE_SIZE, CELL_SIZE / TEXTURE_SIZE, 0>;
        for(index = 0, total = faces; index < total; ++index)
        {
            vector glyph = llList2Vector(glyphs, index);
            vector offsets = <(glyph.x - glyph.z + off.x/2) / TEXTURE_SIZE, glyph.y / -TEXTURE_SIZE, 0>;
            Params += [PRIM_TEXTURE, index, TEXTURE_INTER, repeats, offsets, 0];
        }
        
        renders = llDeleteSubList(renders, 0, 2);
        glyphs = llDeleteSubList(glyphs, 0, faces - 1);
        
        off.y += (off.x / CELL_SIZE) * FontSize / 2;
        
        Params += [
            PRIM_POS_LOCAL, Anchor + <0, off.y, off.z> * Direction,
            PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
            PRIM_SIZE, <(off.x/CELL_SIZE) * FontSize, FontSize, 0.01>
        ];
        
        data += [linkTarget, off.y, off.z];
    }
    
    textRender();
    
    return data;
}










