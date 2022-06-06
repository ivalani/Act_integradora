---

Integrative Activity 5.2 report 



---
Integrative Activity 3.4 report 
# Syntax-highlighter
Integrative Activity 3.4 report 

---
### Team

- Andrea Serrano Diego  - A01028728
- Iwalani Amador Piaga  - A01732251
- Daniel Sanchez Sanchez  - A0178575

##
## _Index_

---

- [Syntax-highlighter](#syntax-highlighter)
    - [Team](#team)
  - [_Index_](#index)
  - [_Program Description_](#program-description)
  - [_Lexical Categories_](#lexical-categories)
  - [_Program Specifications_](#program-specifications)
  - [_How to run_](#how-to-run)
  - [_Solution Reflection_](#solution-reflection)

---
##
## _Program Description_

Using the [Elixir](https://elixir-lang.org/) functional language, a regular expression engine is implemented that takes lexical category expressions to highlight the syntax from a JSON file to HTML.
***
##
## _Lexical Categories_

To make the program possible, the lexical categories are called "tokens" with a label that identifies them categorically:

- Number (all real numbers): `[?0..?9](?=(?:[^"]*"[^"]*")*[^"]*\Z)(?=^) *[\d+E.-]`
- String: `^".*?"`
- Object-Key (For HTML): `^(".*?")(:)`
- Reserved-word (For any language): `true|false|null|for|if|else...`
- Puntuation: `/^[{}\[\]:,]`


##
## _Program Specifications_
The tests and the program use Elixir, you need to [download and install Elixir](https://elixir-lang.org/install.html#windows) with the dependencies that are necessary for your computer (Windows, Mac, Linux...)

* In addition to this you will have to have the dependencies for the use of "mix test"

***Installation***

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `syntax` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hw, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/hw>.
##
## _How to run_

After meeting the above specifications, it is possible to run the program.

1. Copy the repository to a folder and enter the folder (example) 
```powershell
Windows PowerShell
Copyright (C) Microsoft Corporation. Todos los derechos reservados.

Prueba la nueva tecnología PowerShell multiplataforma https://aka.ms/pscore6

PS C:\Users\> cd Downloads
PS C:\Users\Downloads> git clone git@github.com:ivalani/Act_integradora.git

--- Cloning into "Act_integradora" ..... Finished

PS C:\Users\Downloads> cd Act_integradora
PS C:\Users\Downloads\cd Act_integradora>
```
2. Run the tests 


The project has 6 test JSON-HTML files that are executable at the same time thanks to `ExUnit` that executes tests simultaneously with the `mix test` command.
```powershell
PS C:\Users\Downloads\cd Act_integradora> mix test

Finished in 0.1 seconds (0.00s async, 0.1s sync)
1 test, 0 failures

Randomized with seed 820627
```
**If there are problems running the command, it may be necessary to follow the instructions below**
- The following situation occurs
```powershell
PS C:\Users\Downloads\cd Act_integradora> mix test

Unchecked dependencies for envioronment test: 
* nimble_parsec (Hex package)
  the dependency is not available, run "mix deps.get" 
** (Mix) Can´t continue due to errors on dependencies 
```
* Then you should install the Hex dependencies:
***`mix deps.get`*** 
```powershell
PS C:\Users\Downloads\cd Act_integradora> mix deps.get

PS C:\Users\Downloads\cd Act_integradora> mix test

Finished in 0.1 seconds (0.00s async, 0.1s sync)
1 test, 0 failures

Randomized with seed 820627
```
##
## _Solution Reflection_
  We intend to use NimbleParsec is a simple and fast library for text-based parsing combinators. To reduce the syntax of regular expressions, but it was not successful, so we decided to leave the original ones. 




