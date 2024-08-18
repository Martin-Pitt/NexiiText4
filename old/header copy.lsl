// These are the font metrics, with the LSL optimised ones on the left
float UPM = 961.0; // 1000;
float Ascender = 1.0; // 776;
float CapsHeight = 0.91363163371488033298647242455775; // 693;
float Xheight = 0.73361082206035379812695109261186; // 520;
float Baseline = 0.19250780437044745057232049947971;
float Underline = 0.02393340270551508844953173777315; // -162;
float UnderlineThickness = 0.08;
float Descender = 0; // -185;

// Ubuntu Regular
// 1024x1024 Textures that have font size at 66px and font line height at 64px
#define TEXTURE_FONT_1 ""
// #define TEXTURE_FONT_1 "06384125-f81c-d450-a4b2-58408dd9dc8c"
// #define TEXTURE_FONT_2 "1f09fe2c-58b2-0b20-a44e-d34ed9e750d2"
// #define TEXTURE_FONT_3 "0c684f6f-db98-0b73-7b8c-9ccfba7dcf9d"

// Thin white strip to make underline shorter, eight because it's 1/8th of the texture tall
#define TEXTURE_EIGHT "876a12ca-928e-baf1-a35b-f3aab5db95bc"


vector Glyphs(string Glyph) {
	if(Glyph == "e") return <-0.375, 0.484375, 0.5778007507324219>;
	if(Glyph == "t") return <-0.375, 0.453125, 0.32535839080810547>;
	if(Glyph == "a") return <-0.375, 0.421875, 0.5566415786743164>;
	if(Glyph == "o") return <-0.375, 0.390625, 0.593968391418457>;
	if(Glyph == "i") return <-0.375, 0.359375, 0.2381734848022461>;
	if(Glyph == "n") return <-0.375, 0.328125, 0.5859384536743164>;
	if(Glyph == "s") return <-0.375, 0.296875, 0.5219192504882812>;
	if(Glyph == "r") return <-0.375, 0.265625, 0.37044334411621094>;
	if(Glyph == "h") return <-0.375, 0.234375, 0.5863723754882812>;
	if(Glyph == "l") return <-0.375, 0.203125, 0.2381734848022461>;
	if(Glyph == "d") return <-0.375, 0.171875, 0.6070976257324219>;
	if(Glyph == "c") return <-0.375, 0.140625, 0.5659189224243164>;
	if(Glyph == "u") return <-0.375, 0.109375, 0.5863723754882812>;
	if(Glyph == "m") return <-0.375, 0.078125, 0.8718538284301758>;
	if(Glyph == "f") return <-0.375, 0.046875, 0.36301136016845703>;
	if(Glyph == "p") return <-0.375, 0.015625, 0.6070976257324219>;
	if(Glyph == "g") return <-0.375, -0.015625, 0.6079654693603516>;
	if(Glyph == "w") return <-0.375, -0.046875, 0.8109827041625977>;
	if(Glyph == "y") return <-0.375, -0.078125, 0.5564241409301758>;
	if(Glyph == "b") return <-0.375, -0.109375, 0.6070976257324219>;
	if(Glyph == ",") return <-0.375, -0.140625, 0.28049182891845703>;
	if(Glyph == ".") return <-0.375, -0.171875, 0.28049182891845703>;
	if(Glyph == "v") return <-0.375, -0.203125, 0.5564241409301758>;
	if(Glyph == "k") return <-0.375, -0.234375, 0.5442171096801758>;
	if(Glyph == "(") return <-0.375, -0.265625, 0.3574228286743164>;
	if(Glyph == ")") return <-0.375, -0.296875, 0.3574228286743164>;
	if(Glyph == "_") return <-0.375, -0.328125, 0.4558372497558594>;
	if(Glyph == ";") return <-0.375, -0.359375, 0.2929706573486328>;
	if(Glyph == "\"") return <-0.375, -0.390625, 0.4588775634765625>;
	if(Glyph == "=") return <-0.375, -0.421875, 0.6578779220581055>;
	if(Glyph == "'") return <-0.375, -0.453125, 0.2947053909301758>;
	if(Glyph == "-") return <-0.375, -0.484375, 0.45648956298828125>;
	if(Glyph == "x") return <-0.125, 0.484375, 0.5415592193603516>;
	if(Glyph == "/") return <-0.125, 0.453125, 0.3564462661743164>;
	if(Glyph == "0") return <-0.125, 0.421875, 0.62890625>;
	if(Glyph == "$") return <-0.125, 0.390625, 0.6385641098022461>;
	if(Glyph == "*") return <-0.125, 0.359375, 0.49739646911621094>;
	if(Glyph == "1") return <-0.125, 0.328125, 0.40180206298828125>;
	if(Glyph == "j") return <-0.125, 0.296875, 0.2381734848022461>;
	if(Glyph == ":") return <-0.125, 0.265625, 0.28049182891845703>;
	if(Glyph == "{") return <-0.125, 0.234375, 0.4216585159301758>;
	if(Glyph == "}") return <-0.125, 0.203125, 0.4216585159301758>;
	if(Glyph == ">") return <-0.125, 0.171875, 0.6578779220581055>;
	if(Glyph == "q") return <-0.125, 0.140625, 0.6070976257324219>;
	if(Glyph == "[") return <-0.125, 0.109375, 0.3574228286743164>;
	if(Glyph == "]") return <-0.125, 0.078125, 0.3574228286743164>;
	if(Glyph == "2") return <-0.125, 0.046875, 0.6044387817382812>;
	if(Glyph == "z") return <-0.125, 0.015625, 0.5440549850463867>;
	if(Glyph == "!") return <-0.125, -0.015625, 0.2800579071044922>;
	if(Glyph == "<") return <-0.125, -0.046875, 0.6578779220581055>;
	if(Glyph == "?") return <-0.125, -0.078125, 0.5126399993896484>;
	if(Glyph == "3") return <-0.125, -0.109375, 0.6155595779418945>;
	if(Glyph == "+") return <-0.125, -0.140625, 0.6578779220581055>;
	if(Glyph == "5") return <-0.125, -0.171875, 0.5914173126220703>;
	if(Glyph == "\\") return <-0.125, -0.203125, 0.3564462661743164>;
	if(Glyph == "4") return <-0.125, -0.234375, 0.6428499221801758>;
	if(Glyph == "#") return <-0.125, -0.265625, 0.6295576095581055>;
	if(Glyph == "@") return <-0.125, -0.296875, 0.9666881561279297>;
	if(Glyph == "|") return <-0.125, -0.328125, 0.32845115661621094>;
	if(Glyph == "6") return <-0.125, -0.359375, 0.6161031723022461>;
	if(Glyph == "&") return <-0.125, -0.390625, 0.6400833129882812>;
	if(Glyph == "9") return <-0.125, -0.421875, 0.6161031723022461>;
	if(Glyph == "8") return <-0.125, -0.453125, 0.6145839691162109>;
	if(Glyph == "7") return <-0.125, -0.484375, 0.5603303909301758>;
	if(Glyph == "A") return <0.125, 0.484375, 0.6858730316162109>;
	if(Glyph == "B") return <0.125, 0.453125, 0.6525068283081055>;
	if(Glyph == "C") return <0.125, 0.421875, 0.7295465469360352>;
	if(Glyph == "D") return <0.125, 0.390625, 0.7180995941162109>;
	if(Glyph == "E") return <0.125, 0.359375, 0.5986871719360352>;
	if(Glyph == "F") return <0.125, 0.328125, 0.5863180160522461>;
	if(Glyph == "G") return <0.125, 0.296875, 0.7443580627441406>;
	if(Glyph == "H") return <0.125, 0.265625, 0.7392587661743164>;
	if(Glyph == "I") return <0.125, 0.234375, 0.2645406723022461>;
	if(Glyph == "J") return <0.125, 0.203125, 0.5667867660522461>;
	if(Glyph == "K") return <0.125, 0.171875, 0.6676979064941406>;
	if(Glyph == "L") return <0.125, 0.140625, 0.5620660781860352>;
	if(Glyph == "M") return <0.125, 0.109375, 0.8982210159301758>;
	if(Glyph == "N") return <0.125, 0.078125, 0.7485904693603516>;
	if(Glyph == "O") return <0.125, 0.046875, 0.7629127502441406>;
	if(Glyph == "P") return <0.125, 0.015625, 0.6356878280639648>;
	if(Glyph == "Q") return <0.125, -0.015625, 0.7629127502441406>;
	if(Glyph == "R") return <0.125, -0.046875, 0.6423063278198242>;
	if(Glyph == "S") return <0.125, -0.078125, 0.6385641098022461>;
	if(Glyph == "T") return <0.125, -0.109375, 0.6416025161743164>;
	if(Glyph == "U") return <0.125, -0.140625, 0.7395839691162109>;
	if(Glyph == "V") return <0.125, -0.171875, 0.6858730316162109>;
	if(Glyph == "W") return <0.125, -0.203125, 0.9813375473022461>;
	if(Glyph == "X") return <0.125, -0.234375, 0.6780605316162109>;
	if(Glyph == "Y") return <0.125, -0.265625, 0.6746969223022461>;
	if(Glyph == "Z") return <0.125, -0.296875, 0.6271705627441406>;
	if(Glyph == "%") return <0.125, -0.328125, 0.966583251953125>;
	if(Glyph == "^") return <0.125, -0.359375, 0.46744823455810547>;
	if(Glyph == "~") return <0.125, -0.390625, 0.6578779220581055>;
	if(Glyph == "`") return <0.125, -0.421875, 0.31369495391845703>;
	
	/* Ordered according to QWERTY keyboard letter frequency:
		e t a o i n s r h l d c u m f p g w y b , . v k ( ) _ ; " = ' - x /
		0 $ * 1 j : { } > q [ ] 2 z ! < ? 3 + 5  4 # @ | 6 & 9 8 7 % ^ ~ `
		Wasn't sure where to put upper case, so just put them where it made sense.
	*/
	return <0, 0, 0>;
}

// vector Glyphs(string Glyph) {
//     if(Glyph == "e") return <-.25, 0.093750, 2.581686>;
//     if(Glyph == "t") return <0.25, 0.156250, 2.418314>;
//     if(Glyph == "a") return <-.25, 0.343750, 2.543184>;
//     if(Glyph == "o") return <0.25, 0.468750, 2.613944>;
//     if(Glyph == "i") return <-.25, -0.156250, 2.263268>;
//     if(Glyph == "n") return <-.25, -0.468750, 2.597295>;
//     if(Glyph == "s") return <0.25, 0.218750, 2.464100>;
//     if(Glyph == "r") return <0.25, 0.281250, 2.401665>;
//     if(Glyph == "h") return <-.25, -0.093750, 2.594173>;
//     if(Glyph == "l") return <-.25, -0.343750, 2.284079>;
//     if(Glyph == "d") return <-.25, 0.156250, 2.612903>;
//     if(Glyph == "c") return <-.25, 0.218750, 2.483871>;
//     if(Glyph == "u") return <0.25, 0.093750, 2.597295>;
//     if(Glyph == "m") return <-.25, -0.406250, 2.895942>;
//     if(Glyph == "f") return <-.25, 0.031250, 2.401665>;
//     if(Glyph == "p") return <0.25, 0.406250, 2.612903>;
//     if(Glyph == "g") return <-.25, -0.031250, 2.601457>;
//     if(Glyph == "w") return <0.25, -0.031250, 2.808533>;
//     if(Glyph == "y") return <0.25, -0.156250, 2.517169>;
//     if(Glyph == "b") return <-.25, 0.281250, 2.612903>;
//     if(Glyph == ",") return <-.25, -0.343750, 0.255983>;
//     if(Glyph == ".") return <-.25, -0.468750, 0.255983>;
//     if(Glyph == "v") return <0.25, 0.031250, 2.522372>;
//     if(Glyph == "k") return <-.25, -0.281250, 2.543184>;
//     if(Glyph == "(") return <-.25, -0.093750, 0.337149>;
//     if(Glyph == ")") return <-.25, -0.156250, 0.337149>;
//     if(Glyph == "_") return <-.25, 0.468750, 2.511967>;
//     if(Glyph == ";") return <0.25, -0.281250, 0.255983>;
//     if(Glyph == "\"") return <-.25, 0.406250, 0.434964>;
//     if(Glyph == "=") return <0.25, -0.406250, 0.586889>;
//     if(Glyph == "'") return <-.25, -0.031250, 0.250780>;
//     if(Glyph == "-") return <-.25, -0.406250, 0.311134>;
//     if(Glyph == "x") return <0.25, -0.093750, 2.531738>;
//     if(Glyph == "/") return <0.25, 0.468750, 0.399584>;
//     if(Glyph == "0") return <0.25, 0.406250, 0.586889>;
//     if(Glyph == "$") return <-.25, 0.281250, 0.586889>;
//     if(Glyph == "£") return <-.25, 0.218750, 0.586889>;
//     if(Glyph == "€") return <-.25, 0.156250, 0.586889>;
//     if(Glyph == "*") return <-.25, -0.218750, 0.499480>;
//     if(Glyph == "1") return <0.25, 0.343750, 0.586889>;
//     if(Glyph == "j") return <-.25, -0.218750, 2.263268>;
//     if(Glyph == ":") return <0.25, -0.218750, 0.255983>;
//     if(Glyph == "{") return <0.25, -0.281250, 2.346514>;
//     if(Glyph == "}") return <0.25, -0.406250, 2.346514>;
//     if(Glyph == ">") return <0.25, -0.468750, 0.586889>;
//     if(Glyph == "q") return <0.25, 0.343750, 2.612903>;
//     if(Glyph == "[") return <0.25, -0.281250, 1.342352>;
//     if(Glyph == "]") return <0.25, -0.406250, 1.342352>;
//     if(Glyph == "2") return <0.25, 0.281250, 0.586889>;
//     if(Glyph == "z") return <0.25, -0.218750, 2.490114>;
//     if(Glyph == "!") return <-.25, 0.468750, 0.287201>;
//     if(Glyph == "<") return <0.25, -0.343750, 0.586889>;
//     if(Glyph == "?") return <-.25, 0.468750, 1.420395>;
//     if(Glyph == "3") return <0.25, 0.218750, 0.586889>;
//     if(Glyph == "+") return <-.25, -0.281250, 0.586889>;
//     if(Glyph == "5") return <0.25, 0.093750, 0.586889>;
//     if(Glyph == "\\") return <0.25, -0.343750, 1.399584>;
//     if(Glyph == "4") return <0.25, 0.156250, 0.586889>;
//     if(Glyph == "#") return <-.25, 0.343750, 0.694069>;
//     if(Glyph == "@") return <-.25, 0.406250, 1.988554>;
//     if(Glyph == "|") return <0.25, -0.343750, 2.290323>;
//     if(Glyph == "6") return <0.25, 0.031250, 0.586889>;
//     if(Glyph == "9") return <0.25, -0.156250, 0.586889>;
//     if(Glyph == "8") return <0.25, -0.093750, 0.586889>;
//     if(Glyph == "7") return <0.25, -0.031250, 0.586889>;
//     if(Glyph == "A") return <-.25, 0.343750, 1.689906>;
//     if(Glyph == "B") return <-.25, 0.281250, 1.669095>;
//     if(Glyph == "C") return <-.25, 0.218750, 1.645161>;
//     if(Glyph == "D") return <-.25, 0.156250, 1.741935>;
//     if(Glyph == "E") return <-.25, 0.093750, 1.594173>;
//     if(Glyph == "F") return <-.25, 0.031250, 1.558793>;
//     if(Glyph == "G") return <-.25, -0.031250, 1.699272>;
//     if(Glyph == "H") return <-.25, -0.093750, 1.733611>;
//     if(Glyph == "I") return <-.25, -0.156250, 1.279917>;
//     if(Glyph == "J") return <-.25, -0.218750, 1.520291>;
//     if(Glyph == "K") return <-.25, -0.281250, 1.654526>;
//     if(Glyph == "L") return <-.25, -0.343750, 1.540062>;
//     if(Glyph == "M") return <-.25, -0.406250, 1.906348>;
//     if(Glyph == "N") return <-.25, -0.468750, 1.757544>;
//     if(Glyph == "O") return <0.25, 0.468750, 1.809573>;
//     if(Glyph == "P") return <0.25, 0.406250, 1.632674>;
//     if(Glyph == "Q") return <0.25, 0.343750, 1.809573>;
//     if(Glyph == "R") return <0.25, 0.281250, 1.654526>;
//     if(Glyph == "S") return <0.25, 0.218750, 1.553590>;
//     if(Glyph == "T") return <0.25, 0.156250, 1.587929>;
//     if(Glyph == "U") return <0.25, 0.093750, 1.715921>;
//     if(Glyph == "V") return <0.25, 0.031250, 1.682622>;
//     if(Glyph == "W") return <0.25, -0.031250, 1.966701>;
//     if(Glyph == "X") return <0.25, -0.093750, 1.656608>;
//     if(Glyph == "Y") return <0.25, -0.156250, 1.622268>;
//     if(Glyph == "Z") return <0.25, -0.218750, 1.596254>;
//     if(Glyph == "&") return <-.25, 0.031250, 0.693028>;
//     if(Glyph == "%") return <-.25, 0.093750, 0.892820>;
//     if(Glyph == "^") return <0.25, -0.468750, 1.586889>;
//     if(Glyph == "~") return <0.25, -0.468750, 2.586889>;
//     if(Glyph == "`") return <-.25, 0.406250, 2.391259>;
    
//     /* Ordered according to QWERTY keyboard letter frequency:
//         e t a o i n s r h l d c u m f p g w y b , . v k ( ) _ ; " = ' - x /
//         0 $ * 1 j : { } > q [ ] 2 z ! < ? 3 + 5 \ 4 # @ | 6 & 9 8 7 % ^ ~ `
//         Wasn't sure where to put upper case, so just put them where it made sense.
//     */
//     return <0, 0, 0>;
// }



// Resource management
list Free;
list Used;
integer FacesLeft;

// Various accounting
integer LastText;
float LastTxtPos;
float PrevTxtPos;
vector Anchor;
vector Position;
vector Previous;


// The magic user-facing variables
float TextWrapLength = 64.0;
float MaxTextRenderLength = 64.0;
float FontSize = 0.02;
float LineHeight = 0.03;
vector FontColour = <1,1,1>;
rotation Direction = <0,0,0,1>;
//integer OptimiseForHUDs = FALSE;


// Used to take prims from reserve for render
tPlace() { // Internal
    integer Prim = llList2Integer(Free, 0);
    Free = llDeleteSubList(Free, 0, 0);
    Used += Prim;
    FacesLeft = 8;
    LastText = Prim;
    Position += <0,LastTxtPos*FontSize*16,0> * Direction;
    Params += [PRIM_LINK_TARGET, LastText,
        PRIM_POS_LOCAL, Position,
        PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
        PRIM_SIZE, <FontSize*8, FontSize, 0.01>,
        PRIM_COLOR, ALL_SIDES, <1,1,1>, 1.0, // - (0.01*OptimiseForHUDs),
        PRIM_TEXTURE, ALL_SIDES, TEXTURE_TRANSPARENT, ZERO_VECTOR, ZERO_VECTOR, 0.0
    ];
    LastTxtPos = 0.0;
}



// Where you want to start entering text, imagine it as your text cursor pipe
tOrigin(vector Location) { // Public
    FacesLeft = LastText = 0;
    LastTxtPos = 0.0;
    Anchor = Location;
    Position = Location + <0, FontSize*4-FontSize*0.24037, -FontSize*.5>*Direction;
}


// Renders an underline on the previous t() call
tUnderline() { // Public
    integer Prim = llList2Integer(Free, 0);
    Free = llDeleteSubList(Free, 0, 0);
    Used += Prim;
    float Offset = -FontSize*4+FontSize*0.24037;
    float Height = -FontSize*.5*(1.0 - Underline);
    float Thickness = FontSize*UnderlineThickness;
    float Scale = 0.0; if(Thickness < 0.01) { Scale = 0.125 / (Thickness / 0.01); Thickness = 0.01; }
    vector v0 = Previous + <0,Offset + (PrevTxtPos*FontSize*16), Height> * Direction;
    vector v1 = Position + <0,Offset + (LastTxtPos*FontSize*16), Height> * Direction;
    Params += [PRIM_LINK_TARGET, Prim,
        PRIM_POS_LOCAL, (v0+v1)*0.5,
        PRIM_ROT_LOCAL, <.5,.5,.5,.5> * Direction,
        PRIM_SIZE, <llVecDist(v0,v1), Thickness, 0.01>,
        PRIM_COLOR, ALL_SIDES, ZERO_VECTOR, 0.0,
        PRIM_COLOR, 7, FontColour, 1.0,
        PRIM_TEXTURE, ALL_SIDES, TEXTURE_EIGHT, <1.0, Scale, 0.0>, ZERO_VECTOR, 0.0
    ];
}


// The important one, renders desired text
t(string Text) { // Public
    if(LastText < 0) Params += [PRIM_LINK_TARGET, LastText = -LastText];
    Previous = Position;
    PrevTxtPos = LastTxtPos;
    
    float FontSize4Space = -FontSize*4 + FontSize*0.2403746;
    float FontSize16 = FontSize*16;
    
    integer x; integer y = llStringLength(Text);
    for(; x < y; ++x) {
        string Letter = llGetSubString(Text, x, x);
        if(Letter == "\n") { Anchor.z -= LineHeight; tOrigin(Anchor); }
        else if(Letter == " ") LastTxtPos += 0.0150234125; // 0.2403746 * (0.5 / 8 faces)
        else {
            vector Glyph = Glyphs(Letter);
            key Texture;
            if(Glyph.z < 1.0) Texture = TEXTURE_FONT_1;
            else if(Glyph.z < 2.0) Texture = TEXTURE_FONT_2;
            else if(Glyph.z < 3.0) Texture = TEXTURE_FONT_3;
            
            float glyphPosition = ((Position.y + (FontSize4Space + ((LastTxtPos + (Glyph.z - llFloor(Glyph.z)) * .0625)*FontSize16)))-Anchor.y);
            if(glyphPosition > MaxTextRenderLength); // skip
            else
            {
                if(glyphPosition > TextWrapLength) {
                    Anchor.z -= LineHeight;
                    tOrigin(Anchor);
                }
                
                if(FacesLeft == 0) tPlace();
                Glyph.x -= LastTxtPos;
                
                Params += [PRIM_TEXTURE, 8 - FacesLeft, Texture, <0.5, 0.060 /* - (0.01*OptimiseForHUDs)*/, 0>, Glyph, 0.0];
                if(FontColour != <1,1,1>) Params += [PRIM_COLOR, 8 - FacesLeft, FontColour, 1.0 /* - (0.01*OptimiseForHUDs)*/];
                
                FacesLeft--;
                LastTxtPos += (Glyph.z - llFloor(Glyph.z)) * .0625;
            }
        }
    }
}


// Initializes the system by checking for Text prims and resetting them
Init() { // Public
    integer Prims = llGetNumberOfPrims()+1; Params = [];
    while(--Prims) if(llGetLinkName(Prims) == "Text") {
        Free += Prims;
        Params += [PRIM_LINK_TARGET, Prims,
            PRIM_POS_LOCAL, <0,0,0>, PRIM_ROT_LOCAL, <0,0,0,1>,
            PRIM_SIZE, <.01,.01,.01>, PRIM_COLOR, ALL_SIDES, <1,1,1>, 0.0 //,
            //PRIM_PHYSICS_SHAPE_TYPE, PRIM_PHYSICS_SHAPE_NONE
        ];
        if(!(Prims%32)) Render();
    } Render();
}


// Depending how much you draw, make sure to flush the render so you don't stack heap
Render() { // Public
    llSetLinkPrimitiveParamsFast(0, Params); Params = [];
    if(LastText > 0) LastText = -LastText;
} list Params;


// Clears all text prims
Clear() { // Public
    integer Prims = llGetListLength(Used);
    while(Prims--) {
        integer Prim = llList2Integer(Used, Prims);
        Params += [PRIM_LINK_TARGET, Prim,
            PRIM_POS_LOCAL, <0,0,0>, PRIM_ROT_LOCAL, <0,0,0,1>,
            PRIM_SIZE, <.01,.01,.01>, PRIM_COLOR, ALL_SIDES, <1,1,1>, 0.0 //,
            // PRIM_PHYSICS_SHAPE_TYPE, PRIM_PHYSICS_SHAPE_NONE
        ];
        if(!(Prim%32)) Render();
    } Render();
    Free += Used; Used = [];
    tOrigin(Anchor);
}
