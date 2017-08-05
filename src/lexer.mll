{
  open Lexing
  open Parser

  exception SyntaxError of string
  let next_line lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      {
        pos with  pos_bol = lexbuf.lex_curr_pos;
                  pos_lnum = pos.pos_lnum + 1
      }
}

let begin_vcalendar = "BEGIN:VCALENDAR"
let end_vcalendar = "END:VCALENDAR"
let colon = ':'
let word = ['a'-'z' 'A'-'Z']
let version = "VERSION" colon word+
let white = ' '
let newline = '\n'

rule read =
  parse
  | white { read lexbuf }
  | newline { next_line lexbuf ; read lexbuf }
  | begin_vcalendar { BEGIN_VCALENDAR }
  | end_vcalendar { END_VCALENDAR }
  | content { CONTENT (Lexing.lexeme lexbuf) }
  | eof { EOF }
