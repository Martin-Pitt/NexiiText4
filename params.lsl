#define TEXT_DIRECTION 0x1 // [rotation direction]
#define TEXT_COLOR 0x2 // [vector color]
// #define TEXT_FONT_STYLE 0x4 // [integer italic]
// #define TEXT_FONT_WEIGHT 0x8 // [integer weight]
#define TEXT_FONT_SIZE 0x10 // [float size]
#define TEXT_LINE_HEIGHT 0x20 // [float line]
#define TEXT_WRAP_LENGTH 0x40 // [float length]
#define TEXT_TAB_SIZE 0x80 // [float tabSize]
#define TEXT_VARIANT_NUMS 0x100 // [integer VARIANT_NUM_TABULAR] // #define TEXT_VARIANT_NUMS 0x100 // [integer VARIANT_NUM_TABULAR | VARIANT_NUM_OLD | VARIANT_NUM_SLASHED]
// #define TEXT_VARIANT_CAPS 0x200 // [integer VARIANT_CAPS_SMALL | VARIANT_CAPS_ALL_SMALL]
// #define TEXT_VARIANT_LIGS 0x400 // [integer VARIANT_LIGS_COMMON]

#define VARIANT_NUM_TABULAR 0x1

// The params are a single integer bitfield followed by the params arguments if they have any
// Params without argument are booleans, just adding the param is enough
// The params and arguments should follow the order above as that is how they will be parsed
// For example if you want to change the color and set it to bold:
// TEXT_COLOR | TEXT_FONT_BOLD, <0,1,0>
// Or if you want to change the font size, set it to italic and set a wrap length:
// TEXT_FONT_ITALIC | TEXT_FONT_SIZE | TEXT_WRAP_LENGTH, 0.1, 0.4

