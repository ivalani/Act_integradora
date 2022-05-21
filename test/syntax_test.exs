#

defmodule SyntaxTest do
  use ExUnit.Case
  #alias Act_integradora.Sytest
  doctest SyntaxHighlighter

  test "json files" do
    # nombre de defmodule de syntax.ex en "lib" . Operacion de lectura de linea de json file en .ex + ("ubicacion de los archivos")
    #Nota: Test 1,2,5 funcionan
    #SyntaxHighlighter.parseJSON("Test_files/example_0.json", "Page_files/example_0.html")
    SyntaxHighlighter.parseJSON("Test_files/example_1.json", "Page_files/example_1.html")
    SyntaxHighlighter.parseJSON("Test_files/example_2.json", "Page_files/example_2.html")
    #SyntaxHighlighter.parseJSON("Test_files/example_3.json", "Page_files/example_3.html")
    #SyntaxHighlighter.parseJSON("Test_files/example_4.json", "Page_files/example_4.html")
    SyntaxHighlighter.parseJSON("Test_files/example_5.json", "Page_files/example_5.html")

  end

end
