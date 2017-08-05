type component = Component of string

type vcalendar =
  {
    version: string;
    content: string
  }


let component_to_str c = match c with
  | Component x -> x
