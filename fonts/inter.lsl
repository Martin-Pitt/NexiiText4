#define TEXTURE_INTER "e8a04684-47f6-7a26-5cee-6f839de708eb"
#define TEXTURE_EIGHT "876a12ca-928e-baf1-a35b-f3aab5db95bc"
#define TEXTURE_SIZE 2048.
#define FONT_SIZE 40.
#define CELL_SIZE 64.
#define COLUMN_SIZE 186.1818181818182
#define GAP_WIDTH 134.0724431818182

// Convert character into an integer lookup index
integer GlyphIndex(string char)
{
	if(char == "�") return 0; if(char == "0") return 1; if(char == "1") return 2; if(char == "2") return 3; if(char == "3") return 4;
	if(char == "4") return 5; if(char == "5") return 6; if(char == "6") return 7; if(char == "7") return 8; if(char == "8") return 9;
	if(char == "9") return 10; if(char == "a") return 11; if(char == "b") return 12; if(char == "c") return 13; if(char == "d") return 14;
	if(char == "e") return 15; if(char == "f") return 16; if(char == "g") return 17; if(char == "h") return 18; if(char == "i") return 19;
	if(char == "j") return 20; if(char == "k") return 21; if(char == "l") return 22; if(char == "m") return 23; if(char == "n") return 24;
	if(char == "o") return 25; if(char == "p") return 26; if(char == "q") return 27; if(char == "r") return 28; if(char == "s") return 29;
	if(char == "t") return 30; if(char == "u") return 31; if(char == "v") return 32; if(char == "w") return 33; if(char == "x") return 34;
	if(char == "y") return 35; if(char == "z") return 36; if(char == "A") return 37; if(char == "B") return 38; if(char == "C") return 39;
	if(char == "D") return 40; if(char == "E") return 41; if(char == "F") return 42; if(char == "G") return 43; if(char == "H") return 44;
	if(char == "I") return 45; if(char == "J") return 46; if(char == "K") return 47; if(char == "L") return 48; if(char == "M") return 49;
	if(char == "N") return 50; if(char == "O") return 51; if(char == "P") return 52; if(char == "Q") return 53; if(char == "R") return 54;
	if(char == "S") return 55; if(char == "T") return 56; if(char == "U") return 57; if(char == "V") return 58; if(char == "W") return 59;
	if(char == "X") return 60; if(char == "Y") return 61; if(char == "Z") return 62; if(char == ".") return 63; if(char == ",") return 64;
	if(char == ":") return 65; if(char == ";") return 66; if(char == "…") return 67; if(char == "&") return 68; if(char == "\"") return 69;
	if(char == "'") return 70; if(char == "!") return 71; if(char == "?") return 72; if(char == "¿") return 73; if(char == "¡") return 74;
	if(char == "(") return 75; if(char == ")") return 76; if(char == "[") return 77; if(char == "]") return 78; if(char == "{") return 79;
	if(char == "}") return 80; if(char == "_") return 81; if(char == "‐") return 82; if(char == "‑") return 83; if(char == "–") return 84;
	if(char == "—") return 85; if(char == "-") return 86; if(char == "+") return 87; if(char == "/") return 88; if(char == "\\") return 89;
	if(char == "*") return 90; if(char == "%") return 91; if(char == "=") return 92; if(char == "<") return 93; if(char == ">") return 94;
	if(char == "±") return 95; if(char == "×") return 96; if(char == "÷") return 97; if(char == "|") return 98; if(char == "~") return 99;
	if(char == "`") return 100; if(char == "´") return 101; if(char == "^") return 102; if(char == "°") return 103; if(char == "«") return 104;
	if(char == "»") return 105; if(char == "·") return 106; if(char == "#") return 107; if(char == "@") return 108; if(char == "§") return 109;
	if(char == "¶") return 110; if(char == "†") return 111; if(char == "‡") return 112; if(char == "¬") return 113; if(char == "¨") return 114;
	if(char == "µ") return 115; if(char == "$") return 116; if(char == "¢") return 117; if(char == "£") return 118; if(char == "¤") return 119;
	if(char == "¥") return 120; if(char == "©") return 121; if(char == "®") return 122; if(char == "Á") return 123; if(char == "É") return 124;
	if(char == "Í") return 125; if(char == "Ó") return 126; if(char == "Ú") return 127; if(char == "á") return 128; if(char == "é") return 129;
	if(char == "í") return 130; if(char == "ó") return 131; if(char == "ú") return 132; if(char == "′") return 133; if(char == "″") return 134;
	if(char == "À") return 135; if(char == "Â") return 136; if(char == "Æ") return 137; if(char == "Ç") return 138; if(char == "È") return 139;
	if(char == "Ê") return 140; if(char == "Ë") return 141; if(char == "Î") return 142; if(char == "Ï") return 143; if(char == "Ô") return 144;
	if(char == "Ù") return 145; if(char == "Û") return 146; if(char == "Ü") return 147; if(char == "à") return 148; if(char == "â") return 149;
	if(char == "æ") return 150; if(char == "ç") return 151; if(char == "è") return 152; if(char == "ê") return 153; if(char == "ë") return 154;
	if(char == "î") return 155; if(char == "ï") return 156; if(char == "ô") return 157; if(char == "ù") return 158; if(char == "û") return 159;
	if(char == "ü") return 160; if(char == "ÿ") return 161; if(char == "Œ") return 162; if(char == "œ") return 163; if(char == "Ÿ") return 164;
	if(char == "€") return 165; if(char == "−") return 166; if(char == "Ä") return 167; if(char == "Ö") return 168; if(char == "ä") return 169;
	if(char == "ö") return 170; if(char == "ĳ") return 171; if(char == "ß") return 172; if(char == "‚") return 173; if(char == "„") return 174;
	if(char == "Å") return 175; if(char == "Ø") return 176; if(char == "å") return 177; if(char == "ø") return 178; if(char == "Ì") return 179;
	if(char == "Ò") return 180; if(char == "ì") return 181; if(char == "ò") return 182; if(char == "Ñ") return 183; if(char == "ñ") return 184;
	if(char == "Š") return 185; if(char == "š") return 186; if(char == "Ž") return 187; if(char == "ž") return 188; if(char == "Ά") return 189;
	if(char == "Έ") return 190; if(char == "Ή") return 191; if(char == "Ί") return 192; if(char == "Ό") return 193; if(char == "Ύ") return 194;
	if(char == "Ώ") return 195; if(char == "ΐ") return 196; if(char == "Α") return 197; if(char == "Β") return 198; if(char == "Γ") return 199;
	if(char == "Δ") return 200; if(char == "Ε") return 201; if(char == "Ζ") return 202; if(char == "Η") return 203; if(char == "Θ") return 204;
	if(char == "Ι") return 205; if(char == "Κ") return 206; if(char == "Λ") return 207; if(char == "Μ") return 208; if(char == "Ν") return 209;
	if(char == "Ξ") return 210; if(char == "Ο") return 211; if(char == "Π") return 212; if(char == "Ρ") return 213; if(char == "Σ") return 214;
	if(char == "Τ") return 215; if(char == "Υ") return 216; if(char == "Φ") return 217; if(char == "Χ") return 218; if(char == "Ψ") return 219;
	if(char == "Ω") return 220; if(char == "Ϊ") return 221; if(char == "Ϋ") return 222; if(char == "ά") return 223; if(char == "έ") return 224;
	if(char == "ή") return 225; if(char == "ί") return 226; if(char == "ΰ") return 227; if(char == "α") return 228; if(char == "β") return 229;
	if(char == "γ") return 230; if(char == "δ") return 231; if(char == "ε") return 232; if(char == "ζ") return 233; if(char == "η") return 234;
	if(char == "θ") return 235; if(char == "ι") return 236; if(char == "κ") return 237; if(char == "λ") return 238; if(char == "μ") return 239;
	if(char == "ν") return 240; if(char == "ξ") return 241; if(char == "ο") return 242; if(char == "π") return 243; if(char == "ρ") return 244;
	if(char == "ς") return 245; if(char == "σ") return 246; if(char == "τ") return 247; if(char == "υ") return 248; if(char == "φ") return 249;
	if(char == "χ") return 250; if(char == "ψ") return 251; if(char == "ω") return 252; if(char == "ϊ") return 253; if(char == "ϋ") return 254;
	if(char == "ό") return 255; if(char == "ύ") return 256; if(char == "ώ") return 257; if(char == "Ã") return 258; if(char == "Õ") return 259;
	if(char == "ã") return 260; if(char == "õ") return 261; if(char == "Ý") return 262; if(char == "ý") return 263; if(char == "Č") return 264;
	if(char == "č") return 265; if(char == "Ď") return 266; if(char == "ď") return 267; if(char == "Ě") return 268; if(char == "ě") return 269;
	if(char == "Ň") return 270; if(char == "ň") return 271; if(char == "Ř") return 272; if(char == "ř") return 273; if(char == "Ť") return 274;
	if(char == "ť") return 275; if(char == "Ů") return 276; if(char == "ů") return 277; if(char == "Ą") return 278; if(char == "ą") return 279;
	if(char == "Ć") return 280; if(char == "ć") return 281; if(char == "Ę") return 282; if(char == "ę") return 283; if(char == "Ł") return 284;
	if(char == "ł") return 285; if(char == "Ń") return 286; if(char == "ń") return 287; if(char == "Ś") return 288; if(char == "ś") return 289;
	if(char == "Ź") return 290; if(char == "ź") return 291; if(char == "Ż") return 292; if(char == "ż") return 293; if(char == "Ė") return 294;
	if(char == "ė") return 295; if(char == "Į") return 296; if(char == "į") return 297; if(char == "Ū") return 298; if(char == "ū") return 299;
	if(char == "Ų") return 300; if(char == "ų") return 301; if(char == "Ā") return 302; if(char == "ā") return 303; if(char == "Ē") return 304;
	if(char == "ē") return 305; if(char == "Ģ") return 306; if(char == "ģ") return 307; if(char == "Ī") return 308; if(char == "ī") return 309;
	if(char == "Ķ") return 310; if(char == "ķ") return 311; if(char == "Ļ") return 312; if(char == "ļ") return 313; if(char == "Ņ") return 314;
	if(char == "ņ") return 315; if(char == "Đ") return 316; if(char == "‟") return 317; if(char == "Ő") return 318; if(char == "ő") return 319;
	if(char == "Ű") return 320; if(char == "ű") return 321; if(char == "Ǳ") return 322; if(char == "ǳ") return 323; if(char == "⁒") return 324;
	if(char == "⟨") return 325; if(char == "⟩") return 326; if(char == "Ĺ") return 327; if(char == "ĺ") return 328; if(char == "Ľ") return 329;
	if(char == "ľ") return 330; if(char == "Ŕ") return 331; if(char == "ŕ") return 332; if(char == "ǆ") return 333; if(char == "đ") return 334;
	if(char == "Ǆ") return 335; if(char == "Ǉ") return 336; if(char == "ǉ") return 337; if(char == "Ǌ") return 338; if(char == "ǌ") return 339;
	if(char == "Ă") return 340; if(char == "ă") return 341; if(char == "Ș") return 342; if(char == "ș") return 343; if(char == "Ț") return 344;
	if(char == "ț") return 345; if(char == "Ċ") return 346; if(char == "ċ") return 347; if(char == "Ġ") return 348; if(char == "ġ") return 349;
	if(char == "Ħ") return 350; if(char == "ħ") return 351;
	return -1;
}

// Get specs for a glyph: <width, left gap, and right gap>
// Gap is the amount of available transparent space around the glyph
vector GlyphSpec(integer index)
{
	if(index == 0) return <40, 169.1193182, 172.9474432>; if(index == 1) return <24.53125, 172.2443182, 168.1427557>; if(index == 2) return <14.4921875, 157.1271307, 173.0450994>; if(index == 3) return <22.4414063, 162.3029119, 172.9474432>; if(index == 4) return <23.9453125, 170.7404119, 173.6115057>;
	if(index == 5) return <24.7070313, 175.8673651, 170.1154119>; if(index == 6) return <23.0664063, 175.8673651, 170.4181463>; if(index == 7) return <23.359375, 172.4786932, 168.7384588>; if(index == 8) return <20.625, 179.0607244, 169.3927557>; if(index == 9) return <23.28125, 172.4786932, 171.5900213>;
	if(index == 10) return <23.359375, 177.1075994, 172.0978338>; if(index == 11) return <20.703125, 170.5353338, 168.5724432>; if(index == 12) return <22.6171875, 176.7365057, 169.0216619>; if(index == 13) return <20.9179688, 162.3029119, 178.5333807>; if(index == 14) return <22.6171875, 171.8732244, 172.4884588>;
	if(index == 15) return <21.4453125, 158.4747869, 170.4962713>; if(index == 16) return <12.2460938, 161.7853338, 172.4786932>; if(index == 17) return <22.6171875, 174.9396307, 166.0333807>; if(index == 18) return <21.875, 158.2892401, 168.9825994>; if(index == 19) return <8.2421875, 168.1232244, 168.2013494>;
	if(index == 20) return <8.2421875, 170.1154119, 170.9454901>; if(index == 21) return <20.2929688, 172.8302557, 168.2013494>; if(index == 22) return <8.2421875, 170.8966619, 170.5353338>; if(index == 23) return <33.5546875, 173.6896307, 170.8966619>; if(index == 24) return <21.875, 170.9747869, 170.9747869>;
	if(index == 25) return <21.953125, 176.9611151, 169.1193182>; if(index == 26) return <22.6171875, 168.7384588, 170.1154119>; if(index == 27) return <22.6171875, 172.7228338, 164.1974432>; if(index == 28) return <12.890625, 168.5724432, 170.2716619>; if(index == 29) return <18.984375, 171.8732244, 170.3302557>;
	if(index == 30) return <12.4414063, 168.5919744, 170.9161932>; if(index == 31) return <21.875, 172.2443182, 178.7872869>; if(index == 32) return <20.46875, 163.1818182, 178.7872869>; if(index == 33) return <30.078125, 170.9161932, 178.7872869>; if(index == 34) return <20.2734375, 175.9357244, 178.7286932>;
	if(index == 35) return <20.46875, 171.9611151, 169.9982244>; if(index == 36) return <19.140625, 171.2091619, 171.0138494>; if(index == 37) return <26.1328125, 170.8283026, 175.1154119>; if(index == 38) return <25.5273438, 171.6486151, 178.1036932>; if(index == 39) return <28.8867188, 171.5021307, 178.7872869>;
	if(index == 40) return <27.578125, 172.8693182, 172.7033026>; if(index == 41) return <23.1835938, 171.5411932, 172.7033026>; if(index == 42) return <22.1679688, 171.5021307, 178.6700994>; if(index == 43) return <29.21875, 172.8302557, 177.2052557>; if(index == 44) return <28.3203125, 171.8732244, 177.2052557>;
	if(index == 45) return <9.296875, 172.7228338, 177.2052557>; if(index == 46) return <21.3867188, 171.8732244, 177.2052557>; if(index == 47) return <25.3710938, 172.4591619, 175.4865057>; if(index == 48) return <21.40625, 177.0587713, 175.4865057>; if(index == 49) return <34.296875, 171.8732244, 174.0997869>;
	if(index == 50) return <28.3984375, 172.2443182, 176.6388494>; if(index == 51) return <29.9609375, 179.0607244, 176.6388494>; if(index == 52) return <24.4726563, 179.0607244, 173.1818182>; if(index == 53) return <29.9609375, 173.0353338, 163.1818182>; if(index == 54) return <25.2929688, 179.0607244, 174.6075994>;
	if(index == 55) return <24.5703125, 166.4044744, 170.6232244>; if(index == 56) return <24.4140625, 172.2443182, 176.6779119>; if(index == 57) return <28.125, 172.2052557, 176.6779119>; if(index == 58) return <26.1328125, 171.8732244, 173.8068182>; if(index == 59) return <37.96875, 171.8732244, 166.3068182>;
	if(index == 60) return <25.8203125, 176.7365057, 170.6232244>; if(index == 61) return <25.703125, 173.6896307, 170.6232244>; if(index == 62) return <24.53125, 176.9611151, 170.6232244>; if(index == 63) return <8.7890625, 172.2443182, 170.6232244>; if(index == 64) return <8.7890625, 172.9474432, 170.6232244>;
	if(index == 65) return <8.7890625, 168.1427557, 170.6232244>; if(index == 66) return <8.90625, 173.0450994, 177.2638494>; if(index == 67) return <26.3671875, 172.9474432, 170.6232244>; if(index == 68) return <24.3359375, 173.6115057, 178.3575994>; if(index == 69) return <16.1328125, 170.1154119, 178.3575994>;
	if(index == 70) return <10.15625, 170.4181463, 174.4318182>; if(index == 71) return <8.7890625, 168.7384588, 174.7247869>; if(index == 72) return <20.9570313, 169.3927557, 172.7228338>; if(index == 73) return <20.9570313, 171.5900213, 172.7228338>; if(index == 74) return <9.0234375, 172.0978338, 178.7872869>;
	if(index == 75) return <11.953125, 168.5724432, 171.1896307>; if(index == 76) return <11.953125, 169.0216619, 163.7091619>; if(index == 77) return <11.953125, 178.5333807, 172.4396307>; if(index == 78) return <11.953125, 172.4884588, 171.9415838>; if(index == 79) return <15.390625, 170.4962713, 174.0607244>;
	if(index == 80) return <15.390625, 172.4786932, 174.0607244>; if(index == 81) return <18.1640625, 166.0333807, 170.6232244>; if(index == 82) return <13.0859375, 168.9825994, 172.2443182>; if(index == 83) return <13.0859375, 168.2013494, 172.1271307>; if(index == 84) return <20, 170.9454901, 170.8966619>;
	if(index == 85) return <40, 168.2013494, 172.7228338>; if(index == 86) return <17.1484375, 170.5353338, 171.5411932>; if(index == 87) return <25.1171875, 170.8966619, 169.3536932>; if(index == 88) return <13.0078125, 170.9747869, 172.8497869>; if(index == 89) return <13.0078125, 169.1193182, 165.5255682>;
	if(index == 90) return <18.75, 170.1154119, 170.5646307>; if(index == 91) return <33.75, 164.1974432, 170.1154119>; if(index == 92) return <25.1171875, 170.2716619, 171.5900213>; if(index == 93) return <25.1171875, 170.3302557, 178.5333807>; if(index == 94) return <25.1171875, 170.9161932, 168.2013494>;
	if(index == 95) return <25.1171875, 178.7872869, 169.1193182>; if(index == 96) return <25.1171875, 178.7872869, 172.8302557>; if(index == 97) return <25.1171875, 178.7872869, 172.4591619>; if(index == 98) return <11.8359375, 178.7286932, 179.0607244>; if(index == 99) return <25.1171875, 169.9982244, 172.2052557>;
	if(index == 100) return <9.6484375, 171.0138494, 172.2443182>; if(index == 101) return <9.6484375, 175.1154119, 179.4122869>; if(index == 102) return <17.5, 178.1036932, 175.6427557>; if(index == 103) return <16.9140625, 178.7872869, 170.1154119>; if(index == 104) return <20.9179688, 172.7033026, 170.1154119>;
	if(index == 105) return <20.9179688, 172.7033026, 163.8361151>; if(index == 106) return <8.7890625, 178.6700994, 168.7384588>; if(index == 107) return <23.984375, 177.2052557, 171.5900213>; if(index == 108) return <38.9453125, 177.2052557, 171.5900213>; if(index == 109) return <21.484375, 177.2052557, 171.5900213>;
	if(index == 110) return <22.4804688, 177.2052557, 178.5333807>; if(index == 111) return <18.2421875, 175.4865057, 178.5333807>; if(index == 112) return <18.2421875, 175.4865057, 168.2013494>; if(index == 113) return <25.1171875, 174.0997869, 169.1193182>; if(index == 114) return <21.875, 176.6388494, 169.1193182>;
	if(index == 115) return <22.109375, 176.6388494, 169.1193182>; if(index == 116) return <24.5703125, 173.1818182, 172.8302557>; if(index == 117) return <20.9179688, 163.1818182, 172.8302557>; if(index == 118) return <23.28125, 174.6075994, 165.7501776>; if(index == 119) return <27.65625, 170.6232244, 172.7228338>;
	if(index == 120) return <20.6640625, 176.6779119, 172.4591619>; if(index == 121) return <35.3125, 176.6779119, 172.4591619>; if(index == 122) return <25.234375, 173.8068182, 172.4591619>; if(index == 123) return <26.1328125, 166.3068182, 179.0607244>; if(index == 124) return <23.1835938, 170.6232244, 179.0607244>;
	if(index == 125) return <9.296875, 170.6232244, 172.2052557>; if(index == 126) return <29.9609375, 170.6232244, 172.2443182>; if(index == 127) return <28.125, 170.6232244, 172.2443182>; if(index == 128) return <20.703125, 170.6232244, 172.2443182>; if(index == 129) return <21.4453125, 170.6232244, 172.9474432>;
	if(index == 130) return <8.2421875, 177.2638494, 163.4259588>; if(index == 131) return <21.953125, 170.6232244, 164.5392401>; if(index == 132) return <21.875, 178.3575994, 170.3302557>; if(index == 133) return <7.5390625, 178.3575994, 170.5060369>; if(index == 134) return <15.078125, 174.4318182, 170.6232244>;
	if(index == 135) return <26.1328125, 174.7247869, 170.1154119>; if(index == 136) return <26.1328125, 172.7228338, 168.2013494>; if(index == 137) return <38.6914063, 172.7228338, 172.8302557>; if(index == 138) return <28.8867188, 178.7872869, 172.2052557>; if(index == 139) return <23.1835938, 171.1896307, 174.9396307>;
	if(index == 140) return <23.1835938, 163.7091619, 171.6583807>; if(index == 141) return <23.1835938, 172.4396307, 179.6661932>; if(index == 142) return <9.296875, 171.9415838, 176.6779119>; if(index == 143) return <9.296875, 174.0607244, 170.1154119>; if(index == 144) return <29.9609375, 174.0607244, 168.2013494>;
	if(index == 145) return <28.125, 170.6232244, 172.8302557>; if(index == 146) return <28.125, 172.2443182, 172.2052557>; if(index == 147) return <28.125, 172.1271307, 178.5333807>; if(index == 148) return <20.703125, 170.8966619, 168.2013494>; if(index == 149) return <20.703125, 172.7228338, 179.0607244>;
	if(index == 150) return <34.8632813, 171.5411932, 172.2052557>; if(index == 151) return <20.9179688, 169.3536932, 168.9825994>; if(index == 152) return <21.4453125, 172.8497869, 172.2443182>; if(index == 153) return <21.4453125, 165.5255682, 170.8966619>; if(index == 154) return <21.4453125, 170.5646307, 173.6896307>;
	if(index == 155) return <8.2421875, 170.1154119, 170.9161932>; if(index == 156) return <8.2421875, 171.5900213, 173.6115057>; if(index == 157) return <21.953125, 178.5333807, 170.1154119>; if(index == 158) return <21.875, 168.2013494, 169.4611151>; if(index == 159) return <21.875, 169.1193182, 166.8927557>;
	if(index == 160) return <21.875, 172.8302557, 176.4044744>; if(index == 161) return <20.46875, 172.4591619, 167.1368963>; if(index == 162) return <39.5117188, 179.0607244, 166.9513494>; if(index == 163) return <37.2851563, 172.2052557, 167.2540838>; if(index == 164) return <25.703125, 172.2443182, 178.5919744>;
	if(index == 165) return <25.3515625, 179.4122869, 170.1154119>; if(index == 166) return <25.1171875, 175.6427557, 170.4181463>; if(index == 167) return <26.1328125, 170.1154119, 172.4591619>; if(index == 168) return <29.9609375, 170.1154119, 170.2911932>; if(index == 169) return <20.703125, 163.8361151, 171.5900213>;
	if(index == 170) return <21.953125, 168.7384588, 170.9161932>; if(index == 171) return <16.484375, 171.5900213, 169.0216619>; if(index == 172) return <23.046875, 171.5900213, 168.2013494>; if(index == 173) return <7.03125, 171.5900213, 178.5333807>; if(index == 174) return <13.0078125, 178.5333807, 170.4962713>;
	if(index == 175) return <26.1328125, 178.5333807, 170.1154119>; if(index == 176) return <29.9609375, 168.2013494, 166.0333807>; if(index == 177) return <20.703125, 169.1193182, 168.9825994>; if(index == 178) return <21.953125, 169.1193182, 171.2677557>; if(index == 179) return <9.296875, 169.1193182, 168.2013494>;
	if(index == 180) return <29.9609375, 172.8302557, 169.0216619>; if(index == 181) return <8.2421875, 172.8302557, 170.9454901>; if(index == 182) return <21.953125, 165.7501776, 170.7013494>; if(index == 183) return <28.3984375, 172.7228338, 170.9747869>; if(index == 184) return <21.875, 172.4591619, 170.3302557>;
	if(index == 185) return <24.5703125, 172.4591619, 166.2677557>; if(index == 186) return <18.984375, 172.4591619, 170.2716619>; if(index == 187) return <24.53125, 179.0607244, 166.3068182>; if(index == 188) return <19.140625, 179.0607244, 168.4747869>; if(index == 189) return <26.1328125, 172.2052557, 178.5333807>;
	if(index == 190) return <27.4414063, 172.2443182, 170.3302557>; if(index == 191) return <32.578125, 172.2443182, 170.6427557>; if(index == 192) return <13.5546875, 172.2443182, 173.6896307>; if(index == 193) return <32.0898438, 172.9474432, 172.2443182>; if(index == 194) return <32.4609375, 163.4259588, 178.5919744>;
	if(index == 195) return <31.8554688, 164.5392401, 172.2443182>; if(index == 196) return <9.1796875, 170.3302557, 170.6427557>; if(index == 197) return <26.1328125, 170.5060369, 172.0099432>; if(index == 198) return <25.5273438, 170.6232244, 172.9474432>; if(index == 199) return <21.4453125, 170.1154119, 172.2052557>;
	if(index == 200) return <25.78125, 168.2013494, 173.6896307>; if(index == 201) return <23.1835938, 172.8302557, 173.8556463>; if(index == 202) return <24.53125, 172.2052557, 172.2443182>; if(index == 203) return <28.3203125, 174.9396307, 171.4435369>; if(index == 204) return <29.9609375, 171.6583807, 178.5919744>;
	if(index == 205) return <9.296875, 179.6661932, 173.4454901>; if(index == 206) return <25.3710938, 176.6779119, 171.6388494>; if(index == 207) return <26.1328125, 170.1154119, 172.1271307>; if(index == 208) return <34.296875, 168.2013494, 172.4591619>; if(index == 209) return <28.3984375, 172.8302557, 173.1134588>;
	if(index == 210) return <23.828125, 172.2052557, 172.2052557>; if(index == 211) return <29.9609375, 178.5333807, 170.9064276>; if(index == 212) return <28.3203125, 168.2013494, 171.8732244>; if(index == 213) return <24.4726563, 179.0607244, 172.7228338>; if(index == 214) return <24.9609375, 172.2052557, 171.4435369>;
	if(index == 215) return <24.4140625, 168.9825994, 174.0411932>; if(index == 216) return <25.703125, 172.2443182, 172.2443182>; if(index == 217) return <33.828125, 170.8966619, 169.5685369>; if(index == 218) return <25.8203125, 173.6896307, 172.7521307>; if(index == 219) return <33.75, 170.9161932, 168.3966619>;
	if(index == 220) return <29.4140625, 173.6115057, 167.8009588>; if(index == 221) return <9.296875, 170.1154119, 178.5919744>; if(index == 222) return <25.703125, 169.4611151, 172.2443182>; if(index == 223) return <25.078125, 166.8927557, 172.2052557>; if(index == 224) return <18.984375, 176.4044744, 172.2443182>;
	if(index == 225) return <21.875, 167.1368963, 167.8009588>; if(index == 226) return <9.1796875, 166.9513494, 170.1154119>; if(index == 227) return <21.875, 167.2540838, 168.2013494>; if(index == 228) return <25.078125, 178.5919744, 172.8302557>; if(index == 229) return <22.34375, 170.1154119, 172.2052557>;
	if(index == 230) return <20.46875, 170.4181463, 170.3302557>; if(index == 231) return <21.953125, 172.4591619, 172.9474432>; if(index == 232) return <18.984375, 170.2911932, 168.7384588>; if(index == 233) return <18.6523438, 171.5900213, 172.7228338>; if(index == 234) return <21.875, 170.9161932, 169.3927557>;
	if(index == 235) return <23.4765625, 169.0216619, 169.9200994>; if(index == 236) return <9.1796875, 168.2013494, 171.5900213>; if(index == 237) return <19.4726563, 178.5333807, 172.4591619>; if(index == 238) return <23.0859375, 170.4962713, 168.9825994>; if(index == 239) return <22.109375, 170.1154119, 172.2443182>;
	if(index == 240) return <21.4453125, 166.0333807, 170.5353338>; if(index == 241) return <20.1367188, 168.9825994, 176.7365057>; if(index == 242) return <21.953125, 171.2677557, 170.9747869>; if(index == 243) return <24.5507813, 168.2013494, 175.9845526>; if(index == 244) return <22.6171875, 169.0216619, 169.1193182>;
	if(index == 245) return <20.9179688, 170.9454901, 172.2443182>; if(index == 246) return <23.4765625, 170.7013494, 170.1154119>; if(index == 247) return <18.28125, 170.9747869, 172.8302557>; if(index == 248) return <21.875, 170.3302557, 168.7384588>; if(index == 249) return <27.2265625, 166.2677557, 172.7228338>;
	if(index == 250) return <20.859375, 170.2716619, 171.5900213>; if(index == 251) return <29.5703125, 166.3068182, 172.4591619>; if(index == 252) return <30.7617188, 168.4747869, 171.8927557>; if(index == 253) return <9.1796875, 178.5333807, 179.0607244>; if(index == 254) return <21.875, 170.3302557, 168.9825994>;
	if(index == 255) return <21.953125, 170.6427557, 172.2443182>; if(index == 256) return <21.875, 173.6896307, 170.8966619>; if(index == 257) return <30.7617188, 172.2443182, 173.6896307>; if(index == 258) return <26.1328125, 178.5919744, 170.9161932>; if(index == 259) return <29.9609375, 172.2443182, 173.6115057>;
	if(index == 260) return <20.703125, 170.6427557, 170.9161932>; if(index == 261) return <21.953125, 172.0099432, 173.6115057>; if(index == 262) return <25.703125, 172.9474432, 171.5900213>; if(index == 263) return <20.46875, 172.2052557, 172.4591619>; if(index == 264) return <28.8867188, 173.6896307, 178.5333807>;
	if(index == 265) return <20.9179688, 173.8556463, 179.0607244>; if(index == 266) return <27.578125, 172.2443182, 169.1193182>; if(index == 267) return <26.5234375, 171.4435369, 172.2443182>; if(index == 268) return <23.1835938, 178.5919744, 169.1193182>; if(index == 269) return <21.4453125, 173.4454901, 172.2443182>;
	if(index == 270) return <28.3984375, 171.6388494, 170.1154119>; if(index == 271) return <21.875, 172.1271307, 172.8302557>; if(index == 272) return <25.2929688, 172.4591619, 171.5900213>; if(index == 273) return <12.890625, 173.1134588, 172.4591619>; if(index == 274) return <24.4140625, 172.2052557, 168.5724432>;
	if(index == 275) return <14.3945313, 170.9064276, 171.8732244>; if(index == 276) return <28.125, 171.8732244, 178.5333807>; if(index == 277) return <21.875, 172.7228338, 179.0607244>; if(index == 278) return <26.1328125, 171.4435369, 170.4962713>; if(index == 279) return <20.703125, 174.0411932, 173.0353338>;
	if(index == 280) return <28.8867188, 172.2443182, 172.4786932>; if(index == 281) return <20.9179688, 169.5685369, 179.0607244>; if(index == 282) return <23.1835938, 172.7521307, 168.9825994>; if(index == 283) return <21.4453125, 168.3966619, 172.2443182>; if(index == 284) return <22.578125, 167.8009588, 168.7189276>;
	if(index == 285) return <8.2421875, 178.5919744, 176.3849432>; if(index == 286) return <28.3984375, 172.2443182, 168.2013494>; if(index == 287) return <21.875, 172.2052557, 172.2052557>; if(index == 288) return <24.5703125, 172.2443182, 169.1193182>; if(index == 289) return <18.984375, 167.8009588, 172.2443182>;
	if(index == 290) return <24.53125, 170.1154119, 157.1271307>; if(index == 291) return <19.140625, 168.2013494, 162.3029119>; if(index == 292) return <24.53125, 172.8302557, 170.7404119>; if(index == 293) return <19.140625, 172.2052557, 175.8673651>; if(index == 294) return <23.1835938, 170.3302557, 175.8673651>;
	if(index == 295) return <21.4453125, 172.9474432, 172.4786932>; if(index == 296) return <9.296875, 168.7384588, 179.0607244>; if(index == 297) return <8.2421875, 172.7228338, 172.4786932>; if(index == 298) return <28.125, 169.3927557, 177.1075994>; if(index == 299) return <21.875, 169.9200994, 170.5353338>;
	if(index == 300) return <28.125, 171.5900213, 176.7365057>; if(index == 301) return <21.875, 172.4591619, 162.3029119>; if(index == 302) return <26.1328125, 168.9825994, 171.8732244>; if(index == 303) return <20.703125, 172.2443182, 158.4747869>; if(index == 304) return <23.1835938, 170.5353338, 161.7853338>;
	if(index == 305) return <21.4453125, 176.7365057, 174.9396307>; if(index == 306) return <29.21875, 170.9747869, 158.2892401>; if(index == 307) return <22.6171875, 175.9845526, 168.1232244>; if(index == 308) return <9.296875, 169.1193182, 170.1154119>; if(index == 309) return <8.2421875, 172.2443182, 172.8302557>;
	if(index == 310) return <25.3710938, 170.1154119, 170.8966619>; if(index == 311) return <20.2929688, 172.8302557, 173.6896307>; if(index == 312) return <21.40625, 168.7384588, 170.9747869>; if(index == 313) return <8.2421875, 172.7228338, 176.9611151>; if(index == 314) return <28.3984375, 171.5900213, 168.7384588>;
	if(index == 315) return <21.875, 172.4591619, 172.7228338>; if(index == 316) return <28.9257813, 171.8927557, 168.5724432>; if(index == 317) return <13.59375, 179.0607244, 171.8732244>; if(index == 318) return <29.9609375, 168.9825994, 168.5919744>; if(index == 319) return <21.953125, 172.2443182, 172.2443182>;
	if(index == 320) return <28.125, 170.8966619, 163.1818182>; if(index == 321) return <21.875, 173.6896307, 170.9161932>; if(index == 322) return <52.109375, 170.9161932, 175.9357244>; if(index == 323) return <41.7578125, 173.6115057, 171.9611151>; if(index == 324) return <24.8828125, 170.9161932, 171.2091619>;
	if(index == 325) return <14.6289063, 173.6115057, 170.8283026>; if(index == 326) return <14.6289063, 171.5900213, 171.6486151>; if(index == 327) return <21.40625, 172.4591619, 171.5021307>; if(index == 328) return <8.2421875, 178.5333807, 172.8693182>; if(index == 329) return <21.40625, 179.0607244, 171.5411932>;
	if(index == 330) return <12.1484375, 169.1193182, 171.5021307>; if(index == 331) return <25.2929688, 172.2443182, 172.8302557>; if(index == 332) return <12.890625, 169.1193182, 171.8732244>; if(index == 333) return <41.7578125, 172.2443182, 172.7228338>; if(index == 334) return <22.6171875, 170.1154119, 171.8732244>;
	if(index == 335) return <49.4140625, 172.8302557, 172.4591619>; if(index == 336) return <42.7929688, 171.5900213, 177.0587713>; if(index == 337) return <16.484375, 172.4591619, 171.8732244>; if(index == 338) return <49.7851563, 168.5724432, 172.2443182>; if(index == 339) return <30.1171875, 171.8732244, 179.0607244>;
	if(index == 340) return <26.1328125, 178.5333807, 179.0607244>; if(index == 341) return <20.703125, 179.0607244, 173.0353338>; if(index == 342) return <24.5703125, 170.4962713, 179.0607244>; if(index == 343) return <18.984375, 173.0353338, 166.4044744>; if(index == 344) return <24.4140625, 172.4786932, 172.2443182>;
	if(index == 345) return <12.4414063, 179.0607244, 172.2052557>; if(index == 346) return <28.8867188, 168.9825994, 171.8732244>; if(index == 347) return <20.9179688, 172.2443182, 171.8732244>; if(index == 348) return <29.21875, 168.7189276, 176.7365057>; if(index == 349) return <22.6171875, 176.3849432, 173.6896307>;
	if(index == 350) return <29.1796875, 168.2013494, 176.9611151>; if(index == 351) return <21.875, 172.2052557, 172.2443182>;
	return ZERO_VECTOR;
}

// Get texture coords for a glyph: <x, y, 0>
vector GlyphCoords(integer index)
{
	integer column = index / 32;
	integer row = index % 32;
	return <
		(COLUMN_SIZE * column + COLUMN_SIZE * 0.5) - TEXTURE_SIZE/2,
		TEXTURE_SIZE/2 - (CELL_SIZE * row + CELL_SIZE/2),
		0
	>;
}
