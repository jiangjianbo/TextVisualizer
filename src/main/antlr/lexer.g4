// DELETE THIS CONTENT IF YOU PUT COMBINED GRAMMAR IN Parser TAB
lexer grammar ExprLexer;
options { superClass=PythonLexerBase; }
tokens { INDENT, DEDENT } // https://docs.python.org/2.7/reference/lexical_analysis.html#indentation

AND : 'and' ;
OR : 'or' ;
NOT : 'not' ;
EQ : '=' ;
COMMA : ',' ;
SEMI : ';' ;
LPAREN : '(' ;
RPAREN : ')' ;
LCURLY : '{' ;
RCURLY : '}' ;
AS : 'as';

GRAPH_TYPE : 'page' | 'flowchart';

INT : [0-9]+ ;
ID: [a-zA-Z_][a-zA-Z_0-9]* ;
WS: [ \t\n\r\f]+ -> skip ;

NL : '\r'? '\n' -> skip;
STRING : '\'' CHAR_NO_SINGLE_QUOTE* '\'' 
    | '"' CHAR_NO_DOUBLE_QUOTE* '"';

fragment CHAR_NO_SINGLE_QUOTE : ~[\r\n'];
fragment CHAR_NO_DOUBLE_QUOTE : ~[\r\n"];

