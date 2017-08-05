open Lexer
open Lexing

let print_position lexbuf =
  let pos = lexbuf.lex_curr_p in
  Printf.sprintf "Content:%s\nFile: %s\nLine: %d - Col: %d"
    (Lexing.lexeme lexbuf) pos.pos_fname pos.pos_lnum (pos.pos_cnum -
  pos.pos_bol + 1)

let parse_error lexbuf =
  try Parser.prog Lexer.read lexbuf with
  | Parser.Error -> Printf.printf "%s: syntax error\n" (print_position lexbuf);
  exit (-1)

let parse_print lexbuf = match parse_error lexbuf with
  | None -> print_endline ""
  | Some x -> print_endline (Icalendar.component_to_str x)

let loop filename () =
  let inx = open_in filename in
  let lexbuf = Lexing.from_channel inx in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  parse_print lexbuf

let () =
  loop "test/test.ical" ()
