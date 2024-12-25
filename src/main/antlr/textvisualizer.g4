grammar TextVisualizer;

topUnit
    : graphType assign? topBlock EOF
    ;

topBlock 
    : '{' blockContent? '}' linkDef*
    | blockContent? linkDef*
    ;
    
blockContent
    : propertyDef* (objectDef | noteDef | linkDef)*
    ;
    
propertyDef
    : ('@'? definedProperty|'@' Identifier) assign? propertyValue
    ;
    
definedProperty
    : 'style'
    | 'param'
    | 'layout'
    | 'engine'
    | 'title'
    | 'header'
    | 'footer'
    ;

customProperty
    : Identifier
    ;

propertyValue
    : freeText
    | stringValue
    | blockText
    ;

stringValue
    : '"' SChar* '"'
    | '\'' SChar2* '\''
    ;

blockText
    : '"""' textFormat? .* '"""'
    | '\'\'\'' textFormat? .* '\'\'\''
    ;

textFormat
    : Identifier
    ;

objectDef
    : objectHead assign? '{' blockContent? '}'
    ;
    
objectHead
    : objectType objectTitle ('as' objectAlias)? objectPrototype? colorDef?
    | objectAlias objectTitleWithShape? objectPrototype? colorDef?
    | objectTitleWithShape objectPrototype? colorDef?
    ;

objectTitle
    : Identifier+
    | stringValue
    ;

objectPrototype
    : '<<' Identifier (',' Identifier)* '>>'
    ;

colorDef
    : colorValue (',' colorValue)*
    ;

colorValue
    : '#' HexadecimalDigit HexadecimalDigit HexadecimalDigit
    | '#' HexadecimalDigit HexadecimalDigit HexadecimalDigit HexadecimalDigit HexadecimalDigit HexadecimalDigit
    | '#' colorName
    ;

colorName
    : 'black'
    | 'red'
    | 'green'
    | 'yellow'
    | 'blue'
    | 'magenta'
    | 'cyan'
    | 'white'
    ;

objectAlias
    : Identifier
    ;

// reference https://mermaid.js.org/syntax/flowchart.html
objectTitleWithShape
    : objectTitle
    | '[' objectTitle ']'       // Rectangle
    | '[/' objectTitle '\\]'    // Trapezoid
    | '[\\' objectTitle '/]'    // Trapezoid alt
    | '[\\' objectTitle '\\]'   // Parallelogram alt
    | '[/' objectTitle '/]'     // Parallelogram
    | '[(' objectTitle ')]'     // cylindrical shape, database
    | '[[' objectTitle ']]'     // subroutine shape
    | '(' objectTitle ')'       // round edges
    | '((' objectTitle '))'     // circle
    | '(((' objectTitle ')))'   // Double circle
    | '([' objectTitle '])'     // stadium-shaped
    | '>' objectTitle ']'       // asymmetric shape
    | '[' objectTitle '<'       // asymmetric shape reverse
    | '{' objectTitle '}'       // rhombus
    | '{{' objectTitle '}}'     // hexagon
    | '{{{' objectTitle '}}}'   // pentagon, five star
    | '{<' objectTitle '>}'     // explode star
    ;

objectType
    : 'node'
    | 'class'
    | 'object'
    | 'package'
    | 'usecase'
    | 'actor'
    | 'interface'
    | '()'
    | '<>'
    | 'map'
    | 'json'
    ;

noteDef
    : noteHead assign? propertyValue
    ;

noteHead
    : 'note' noteDirection? noteAlias?
    | 'note' noteAlias noteDirection?
    ;

noteDirection
    : direction of objectRef
    ;

direction
    : 'left'
    | 'right'
    | 'up'
    | 'down'
    ;

noteAlias
    : Identifier
    ;

linkDef
    : linkAlias? linkPort linkArrow linkPort (':' linkLabel)?
    ;

linkAlias
    : 'link' 'as' Identifier
    ;

linkPort
    : objectRef ('#' Identifier)? linkPortText?
    ;

linkArrow
    : arrowHead direction? arrowTail
    ;

arrowHead
    : arrowLeft? arrowLine+
    ;

arrowTail
    : arrowLine+ arrowRight?
    ;

arrowLeft
    : '<'
    | '<<'
    | 'o<'
    ;

arrowRight
    : '>'
    | '>>'
    | '>o'
    ;

arrowLine
    : '-'
    | '='
    | '~'
    | '.'
    | '-.-'
    ;

defaultArrow
    : '-->'
    | '--'
    | '->'
    | '---'
    | '==>'
    | '=='
    | '=>'
    | '==='
    ;

linkLabel
    : propertyValue
    | '<' propertyValue
    | propertyValue '>'
    ;

assign
    : ':' | '='
    ;

graphType
    : 'flowchart'
    | 'classDiagram'
    | 'sequenceDiagram'
    | 'useCase'
    | 'activityDiagram'
    ;

fragment freeText
    : freeChar+
    ;

fragment freeChar
    : ~["\\\r\n'{}]
    | EscapeSequence
    | '\\\n'      // Added line
    | '\\\r\n' // Added line
    ;

Identifier
    : IdentifierNondigit (IdentifierNondigit | Digit)*
    ;

fragment IdentifierNondigit
    : Nondigit
    | UniversalCharacterName
    //|      // other implementation-defined characters...
    ;

fragment Nondigit
    : [a-zA-Z_]
    ;

fragment Digit
    : [0-9]
    ;

fragment UniversalCharacterName
    : '\\u' HexQuad
    | '\\U' HexQuad HexQuad
    ;

fragment HexQuad
    : HexadecimalDigit HexadecimalDigit HexadecimalDigit HexadecimalDigit
    ;

Constant
    : IntegerConstant
    | FloatingConstant
    //|      EnumerationConstant
    | CharacterConstant
    ;

fragment IntegerConstant
    : DecimalConstant IntegerSuffix?
    | OctalConstant IntegerSuffix?
    | HexadecimalConstant IntegerSuffix?
    | BinaryConstant
    ;

fragment BinaryConstant
    : '0' [bB] [0-1]+
    ;

fragment DecimalConstant
    : NonzeroDigit Digit*
    ;

fragment OctalConstant
    : '0' OctalDigit*
    ;

fragment HexadecimalConstant
    : HexadecimalPrefix HexadecimalDigit+
    ;

fragment HexadecimalPrefix
    : '0' [xX]
    ;

fragment NonzeroDigit
    : [1-9]
    ;

fragment OctalDigit
    : [0-7]
    ;

fragment HexadecimalDigit
    : [0-9a-fA-F]
    ;

fragment IntegerSuffix
    : UnsignedSuffix LongSuffix?
    | UnsignedSuffix LongLongSuffix
    | LongSuffix UnsignedSuffix?
    | LongLongSuffix UnsignedSuffix?
    ;


fragment Sign
    : [+-]
    ;

DigitSequence
    : Digit+
    ;

fragment HexadecimalFractionalConstant
    : HexadecimalDigitSequence? '.' HexadecimalDigitSequence
    | HexadecimalDigitSequence '.'
    ;

fragment HexadecimalDigitSequence
    : HexadecimalDigit+
    ;

fragment CharacterConstant
    : '\'' CCharSequence '\''
    | 'L\'' CCharSequence '\''
    | 'u\'' CCharSequence '\''
    | 'U\'' CCharSequence '\''
    ;

fragment CCharSequence
    : CChar+
    ;

fragment CChar
    : ~['\\\r\n]
    | EscapeSequence
    ;

fragment EscapeSequence
    : SimpleEscapeSequence
    | OctalEscapeSequence
    | HexadecimalEscapeSequence
    | UniversalCharacterName
    ;

fragment SimpleEscapeSequence
    : '\\' ['"?abfnrtv\\]
    ;

fragment OctalEscapeSequence
    : '\\' OctalDigit OctalDigit? OctalDigit?
    ;

fragment HexadecimalEscapeSequence
    : '\\x' HexadecimalDigit+
    ;

StringLiteral
    : '"' SCharSequence? '"'
    | '\'' SChar2Sequence? '\''
    ;


fragment SCharSequence
    : SChar+
    ;

fragment SChar2Sequence
    : SChar2+
    ;

fragment SChar
    : ~["\\\r\n]
    | EscapeSequence
    | '\\\n'      // Added line
    | '\\\r\n' // Added line
    ;

fragment SChar2
    : CChar
    | '\\\n'      // Added line
    | '\\\r\n' // Added line
    ;


Whitespace
    : [ \t]+ -> channel(HIDDEN)
    ;

Newline
    : ('\r' '\n'? | '\n') -> channel(HIDDEN)
    ;

BlockComment
    : '/*' .*? '*/' -> channel(HIDDEN)
    ;

LineComment
    : '//' ~[\r\n]* -> channel(HIDDEN)
    ;
