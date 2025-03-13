// Settings
vector Color = <1,1,1>;
// integer FontWeight = 400; 
float FontSize = 0.5;
float LineHeight = 1.4;
// string FontFamily = "Inter";
// string TextWrap = "wrap"; // "nowrap"
float TextWrapLength = 64.0;
// string TextOverflow = "clip"; // "ellipsis"
// integer TextShadow = FALSE;
// vector TextShadowColor = <0,0,0>;
// vector TextShadowWeight = 700;
// float TextShadowOffsetX = 0.05;
// float TextShadowOffsetY = 0.05;
float TabSize = 4;
integer TabularFigures = FALSE;
// string WritingDirection = "LTR";

// Positional (m)
vector Anchor = <0,0,0>;
rotation Direction = <0,0,0,1>;

// Positional (px)
vector Cursor;
// float lastSplitPos;
// float lastPrintPos;
// float lastSpacePos;

// Indexes -- string character indexes
// integer lastPrintStart;
// integer lastPrintIndex;

// Misc
// integer facesLeft = 8;
// list glyphs = [/* rotation[] glyph = <centerOfGlyph.xy, glyphWidth, glyphPrintablePosX> */];
// list printables = [/* x, y, width, linkTarget, glyphsStart, glyphsTotal, txtStart */];
// list printableGlyphs = [/* rotation[] glyph = <centerOfGlyph.xy, glyphWidth, glyphPrintablePosX> */];
// integer isNewline = FALSE;
// integer isWrapping = FALSE;
string TAB; // Set to real tab character on textInit()




// Current working island
float islandX;
float islandY;
float islandAvailableWidth;
string islandChar0; float islandPos0;
string islandChar1; float islandPos1;
string islandChar2; float islandPos2;
string islandChar3; float islandPos3;
string islandChar4; float islandPos4;
string islandChar5; float islandPos5;
string islandChar6; float islandPos6;
string islandChar7; float islandPos7;
integer islandFacesFree;

list Printables;

string TEXTURE_FONT;
float TEXTURE_SIZE;
float FONT_SIZE;
float CELL_SIZE;
float FONT_BY_CELL;
float COLUMN_SIZE;
float METERS_TO_PIXELS;
float PIXELS_TO_METERS;
float wrapLength;
float tabWidth;
float whitespace;
integer isNewline;