type component = Component of string

type vcalendar =
  {
    version: string;
    content: string
  }

val component_to_str : component -> string
