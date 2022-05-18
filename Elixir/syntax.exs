
#Program that takes json files and returns an html for syntax highlighting
' Actividad integradora 3.4 - Resaltador de sintaxis

Andrea Serrano Diego  -
Iwalani Amador Piaga  - A01732251
Daniel Sanchez Sanchez  -
'
defmodule Syntax do
  def json_to_hmtl(in_filename, out_filename) do
    template = File.read("Page_files/template_page")
    tokens =
      in_filename
      |> Enum.stream!() #generate row list
      |> Enum.map()
      |> Enum.joint("\n")
    File.write(out_filename,tokens)
  end

  def token?(line) do

  end
end
