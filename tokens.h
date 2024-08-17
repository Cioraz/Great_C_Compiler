enum TOKEN {
    // Keywords
    // AUTO = 1,
    AUTO,
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
    SIGNED,
    SIZEOF,
    STATIC,
    STRUCT,
    SWITCH,
    TYPEDEF,
    UNION,
    UNSIGNED,
    VOID,
    VOLATILE,
    WHILE,

    // Identifiers and comments
    IDENTIFIER,
    SLC,    // Single Line Comment
    MLCS,   // Multi-Line Comment Start
    // MLCE,   // Multi-Line Comment End - Why

    // Operators
    LEQ,    // <=
    GEQ,    // >=
    EQEQ,   // ==
    NEQ,    // !=
    LOR,    // ||
    LAND,   // &&
    ASSIGN, // =
    PLUS,   // +
    SUB,    // -
    MULT,   // *
    DIV,    // /
    MOD,    // %
    LESSER, // <
    GREATER,// >
    INCR,   // ++
    DECR,   // --

    // Special symbols
    COMMA,  // ,
    SEMI,   // ;
    DQ,     // "
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
    DEFINE,
    GETCH,
    STRLEN,
    PUTS,
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
    SIGNED_CONST,
    STRING_CONST,

    // Arrays and functions
    ARR,
    FUNC,

    // Errors
    // NUM_ERR,
    // UNKNOWN,

    // Include files
    STRINGH,
    MATH
};
