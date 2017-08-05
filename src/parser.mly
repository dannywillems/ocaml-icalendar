%token BEGIN_VCALENDAR
%token <string> CONTENT
%token END_VCALENDAR
%token EOF

%start <Icalendar.component option> prog
%%

prog:
  | EOF { None }
  | v = vcalendar { Some v }
  ;

vcalendar: BEGIN_VCALENDAR ; s = content ; END_VCALENDAR { Icalendar.Component s }

content: s = CONTENT { s }
