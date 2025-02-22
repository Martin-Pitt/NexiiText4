// Underlines the given rendered text
// Assumes called immediately after textRender()

float UNDERLINE_THICKNESS = 4.0;
float UNDERLINE_OFFSET = 8.0;
list textUnderline(list render) {
    integer line = llList2Integer(Free, 0);
    Free = llDeleteSubList(Free, 0, 0);
    Used += line;
    float textWidth = llList2Float(render, 0);
    vector position = <0, textWidth*.5, Cursor.y - FontSize * UNDERLINE_OFFSET / CELL_SIZE> * Direction;
    llSetLinkPrimitiveParamsFast(line, [
        PRIM_COLOR, 7, <1,1,1>, 1,
        PRIM_TEXTURE, 7, TEXTURE_BLANK, <1,1,0>, <0,0,0>, 0,
        PRIM_POS_LOCAL, Anchor + position,
        PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
        PRIM_SIZE, <textWidth, FontSize * UNDERLINE_THICKNESS / CELL_SIZE, .01>
    ]);
    return [line, position];
}
