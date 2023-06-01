IO.puts("Let's understand aliases better")

IO.puts is_atom(String)
IO.puts to_string(String)
IO.puts :"Elixir.String" == String

defmodule UsesAlias do
  alias Enum, as: Enumerable

  def example do
    IO.puts Enumerable.intersperse(["using", "alias", "to", "rename", "Enum"], ?\s)
    IO.puts ""
  end
end

UsesAlias.example()

defmodule UsesRequire do
  require Integer

  def example do
    IO.puts "using 'require Integer' we make its macro is_odd\\1 available"
    IO.puts "is 3 odd ? #{Integer.is_odd(3)}"
    IO.puts ""
  end
end

UsesRequire.example()

defmodule UsesImport do
  import Integer

  def example do
    IO.puts "using 'import Integer' we can call is_odd\\1 without the Integer namespace"
    IO.puts "is 11 odd ? #{is_odd(11)}"
    IO.puts ""
  end
end

UsesImport.example()

