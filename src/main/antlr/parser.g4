parser grammar ExprParser;
options { tokenVocab=ExprLexer; }

tv_graph
    : (NL | stmt)* EOF
    ;

stmt : graph_block | simple_stmt;

graph_block : graph_block_def graph_block_body;

graph_block_def : graph_type graph_title?;

graph_title : STRING (AS ID)?;
graph_type : GRAPH_TYPE;

graph_block_body : c_block_body | py_block_body;

c_block_body : LCURLY stmt* RCURLY;

py_block_body : NL INDENT stmt DEDENT;

simple_stmt : ID+;

