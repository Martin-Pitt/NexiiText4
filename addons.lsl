// Underlines the given rendered text

// You can change these settings
float UnderlineThickness = 4.0;
float UnderlineOffset = 8.0;

// Called with the return value of textRender()
list textUnderline(list render) {
    integer line = LinksetResourceReserve("NT4");
    float textWidth = llList2Float(render, 0);
    vector position = <0, textWidth*.5, Cursor.y - FontSize * UnderlineOffset / CELL_SIZE> * Direction;
    llSetLinkPrimitiveParamsFast(line, [
        PRIM_COLOR, 7, <1,1,1>, 1,
        PRIM_TEXTURE, 7, TEXTURE_BLANK, <1,1,0>, <0,0,0>, 0,
        PRIM_POS_LOCAL, Anchor + position,
        PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
        PRIM_SIZE, <textWidth, FontSize * UnderlineThickness / CELL_SIZE, .01>
    ]);
    return [line, position];
}


