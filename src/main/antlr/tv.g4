grammar tv;

topUnit
    : graphType assign? topBlock EOF
    ;

topBlock 
    : linkDef*
    ;
    
objectRef
    : Identifier
    ;

direction
    : 'left'
    | 'right'
    | 'up'
    | 'down'
    ;

linkDef
    : linkAlias? linkPort linkArrow linkPort
    ;

linkAlias
    : 'link' 'as' Identifier
    ;

linkPort
    : objectRef ('#' Identifier)?
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
