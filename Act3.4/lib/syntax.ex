# Program that takes json files and returns an html for syntax highlighting
' Actividad integradora 3.4 - Resaltador de sintaxis

Andrea Serrano Diego  - A01028728
Iwalani Amador Piaga  - A01732251
Daniel Sanchez Sanchez  - A0178575
'

# --------------------------------------------------List of REGEX -------------------------------------------------
# REGEX for KEYS:(?=^) *"[\w0-9:-]+"(?=:)
# REGEX for VALUES (String):(?!.*:)(?=^) *"[\(\)\;a-zA-z0-9.&': ?@+!=\/.\*,-]+"| *"[\(\)\;a-zA-z0-9.&': ?@+!=\/.\*,-]+"(?=,)
# REGEX for punctuation:(?=^) *[{},:\[\]]+
# REGEX for reserved words:(?!.*\d)(?=^)(?=(?:[^"]*"[^"]*")*[^"]*\Z) *[a-zA-Z]
# REGEX for numbers:(?=(?:[^"]*"[^"]*")*[^"]*\Z)(?=^) *[\d+E.-]

# defmodule Evidencia do
defmodule SyntaxHighlighter do
  @moduledoc false

  # parsec:MyParser
  # import NimbleParsec

  def parseJSON(in_filename, out_filename) do
    html =
      in_filename
      |> File.stream!()
      |> Enum.map(&readLine/1)
      |> IO.inspect()
      |> Enum.join("")

    html = """
    <!DOCTYPE html>

    <html>

      <head>

      <title>JSON Code</title>

      <link rel="stylesheet" href="token_colors.css" />

      </head>

      <body>

        <h1>Current Time: #{NaiveDateTime.local_now()}</h1>

        <pre>

    #{html}

        </pre>

      </body>

    </html>

    """

    File.write(out_filename, html)
  end

  # Reads all lines unitl there are no more
  def readLine(line), do: do_readLine(line, "")
  defp do_readLine(line, ""), do: do_readSpaces(line, "")
  defp do_readLine(line, htmlLine), do: do_readSpaces(line, htmlLine)
  defp do_readLine("", htmlLine), do: htmlLine

  defp do_readSpaces(line, htmlLine) do
    if !Regex.run(~r/^\s+/, line) do
      do_readObjectKey(line, htmlLine)
    else
      tuple = getSpaces(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end

  defp do_readObjectKey(line, htmlLine) do
    if !Regex.run(~r/^(".*?")(:)/, line) do
      do_readString(line, htmlLine)
    else
      tuple = getKey(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end

  defp do_readString(line, htmlLine) do
    if !Regex.run(~r/^".*?"/, line) do
      do_readpunt(line, htmlLine)
    else
      tuple = getString(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end

  defp do_readpunt(line, htmlLine) do
    tuple = getpunt(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end

  defp do_readLine(line, htmlLine) do
    tuple = getNum(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end

  defp do_readLine(line, htmlLine) do
    tuple = getReserved(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end

  defp do_readLine(line, htmlLine) do
    tuple = getReserved(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end

  def getpunt(line, htmlLine) do
    lineTemp = line
    [punt] = Regex.run(~r/^[{}\[\]:,]/, line)
    line = elem(String.split_at(lineTemp, String.length(punt)), 1)
    tags = "<span class=\"punt\">#{punt}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getString(line, htmlLine) do
    lineTemp = line
    [string] = Regex.run(~r/^".*?"/, line)
    line = elem(String.split_at(lineTemp, String.length(string)), 1)
    tags = "<span class=\"string\">#{string}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getKey(line, htmlLine) do
    lineTemp = line
    #[completeLine, objectKey, punt] = Regex.run(~r/^(:)/, line)
    [completeLine, objectKey, punt] = Regex.run(~r/^(".*?")(:)/, line)
    line = elem(String.split_at(lineTemp, String.length(completeLine)), 1)

    tags = "<span class=\"objectKey\">#{objectKey}</span><span class=\"punt\">#{punt}</span>"

    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getReserved(line, htmlLine) do

    lineTemp = line
    # [reserver_word] = Regex.run(ascii_string([?0..?9], line))
    [reserved_word] = Regex.run(~r/true|false|True|False|Null|null|NULL/, line)
    line = elem(String.split_at(lineTemp, String.length(reserved_word)), 1)
    tags = "<span class=\"reserved_word\">#{reserved_word}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
    # Regex.run()
  end

  def getNum(line, htmlLine) do
    lineTemp = line
    # [number] = Regex.run(ascii_string([?0..?9], line))
    [number] = Regex.run(~r/(?=(?:[^"]*"[^"]*")*[^"]*\Z)(?=^) *[\d+E.-]/, line)
    line = elem(String.split_at(lineTemp, String.length(number)), 1)
    tags = "<span class=\"number\">#{number}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
    # Regex.run()
  end

  # def getNull(line, htmlLine) do
  # Regex.run()
  # end

  def getSpaces(line, htmlLine) do
    lineTemp = line
    [whitespaces] = Regex.run(~r/^\s+/, line)
    line = elem(String.split_at(lineTemp, String.length(whitespaces)), 1)
    htmlLine = "#{htmlLine}#{whitespaces}"
    {line, htmlLine}
  end
end
