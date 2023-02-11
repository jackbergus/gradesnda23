grammar scratch;

lang: sigma (global|sglobal)* declare+;

gen: (global|sglobal)* event* declarative* ;

sigma: 'sigma' '[' STRING* ']';
event: 'event' STRING '{' var* '}';
global: 'nglobal' var '[' low=(INTNUMBER|NUMBER) ':' high=(INTNUMBER|NUMBER) ']';
sglobal: 'sglobal' var '[' STRING* ']';
declare: STRING '(' (field ',')* field ')' ('where' labelLHS=STRING '.' vLHS=var op=OP  labelRHS=STRING '.' vRHS=var)?;
declarative: 'template' STRING '#' INTNUMBER;
cond : label=STRING '.' v=var op=OP val=(INTNUMBER|NUMBER|STRING) #actualcond
     | 'true' #true;
field :(STRING ',' cond );

OP: '<' | '>' | '<=' | '>=' | '=' | '!=';

var: 'var' STRING;
LABEL: ('A'..'Z')[a-zA-Z]*;
INTNUMBER : '-'? ('0'..'9')+ ;
NUMBER : '-'? INTNUMBER ('.' INTNUMBER)?;
STRING : '"' (~[\\"] | '\\' [\\"])* '"';
SPACE : [ \t\r\n]+ -> skip;

COMMENT
    : '/*' .*? '*/' -> skip
;

LINE_COMMENT
    : '//' ~[\r\n]* -> skip
;