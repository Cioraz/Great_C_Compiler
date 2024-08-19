#ifndef TOKEN_H
#define TOKEN_H

enum TOKEN {
    // Keywords
    AUTO=1,
    BREAK,
    CASE,
    CHAR,
    CONST,
    CONTINUE,
    DEFAULT,
    DO,
    DOUBLE,
    ELSE,
    ENUM,
    EXTERN,
    FLOAT,
    FOR,
    GOTO,
    IF,
    INT,
    LONG,
    REGISTER,
    RETURN,
    SHORT,
    SIGNED, // later handle
    SIZEOF,
    STATIC,
    STRUCT,
    SWITCH,
    TYPEDEF,
    UNION,
    //UNSIGNED, // later handle
    VOID,
    VOLATILE,
    WHILE,

    PREPROCESSOR_INSTR,
    MAIN,

    // Identifiers and comments
    IDENTIFIER,
    SLC,    // Single Line Comment
    MLCS,   // Multi-Line Comment Start
    MLCE,   // Multi-Line Comment End - Why

    // Operators
    LEQ,    // <=
    GEQ,    // >=
    EQEQ,   // ==
    NEQ,    // !=
    LOR,    // ||
    LAND,   // &&
    ASSIGN, // =
    PLUS,   // +
    MINUS,    // -
    MULT,   // *
    DIV,    // /
    MOD,    // %
    LT, // <
    GT, // >
    INCR,   // ++
    DECR,   // --
    LNOT,   // !
    BNOT,  // ~
    BAND,  // &
    BOR,   // |
    XOR,   // ^
    LSHIFT, // <<
    RSHIFT, // >>

    // Special symbols
    COMMA,  // ,
    SEMICOLON,   // ;
    DQ,     // " -> handle this in scanner
    OBO,    // (
    OBC,    // )
    CBO,    // {
    CBC,    // }
    HASH,   // #

    // Headers and main
    // HEADER,
    // MAIN,

    // Functions
    PRINTF,
    SCANF,
    MALLOC,
    CALLOC,
    REALLOC,
    FREE,
    //DEFINE,
    // handle fopen
    // derive
    // ifdef

    // String library functions
    //
    PUTS,
    GETCH,
    STRLEN,
    STRCMP,
    STRCAT,
    STRCPY,

    // Math library functions
    CEIL,
    FLOOR,
    FABS,
    LOG,
    SQRT,
    POW,
    EXP,

    // Constants
    INT_CONST,
    FLOAT_CONST,
    CHAR_CONST,
   // SIGNED_CONST, // later handle
    STRING_CONST,
    // unsigned

    // Arrays and functions
    ARR,
    FUNC,

    // Errors
    NUM_ERR,
    UNKNOWN,

    // Include files
    // STRINGH,
    // MATH
};

#endif
