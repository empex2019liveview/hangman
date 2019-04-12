defmodule Hangman.Words do
  @languages [
    "algol",
    "assembler",
    "basic",
    "c",
    "c#",
    "c++",
    "clojure",
    "d",
    "erlang",
    "elixir",
    "f#",
    "fortran",
    "go",
    "haskell",
    "java",
    "javascript",
    "lisp",
    "lua",
    "pascal",
    "perl",
    "php",
    "prolog",
    "python",
    "ruby",
    "scala",
    "scheme",
    "simula",
    "smalltalk",
    "swift",
    "umple"
  ]

  def pick, do: @languages |> Enum.random()
end
