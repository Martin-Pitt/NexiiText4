// Resources
list Free; // Links of freely available text meshes
list Used; // Links of text meshes that are currently in use
list Bin; // Links that had been just free'd and ready to be recycled or dropped into free asap (with prim params reset)

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
float islandAvailableWidth = COLUMN_SIZE;
vector islandGlyph0;
vector islandGlyph1;
vector islandGlyph2;
vector islandGlyph3;
vector islandGlyph4;
vector islandGlyph5;
vector islandGlyph6;
vector islandGlyph7;
integer islandFacesFree = 8;

list Printables = [];

float METERS_TO_PIXELS;
float PIXELS_TO_METERS;
float wrapLength;
float tabWidth;
float whitespace;
integer isNewline;