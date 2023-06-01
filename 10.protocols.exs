# protocols are a means to achieve polymorphism in Elixir
# useful when you want behavior to vary depending on the data type

defmodule Utility do
  def type(value) when is_binary(value), do: "string"
  def type(value) when is_integer(value), do: "integer"
  # 😥 we'll be here for a while if we need to add this for each type in our program
end

defmodule Example do
  def prettyprint(something) do
    IO.puts("The type of (#{something}) is #{Utility.type(something)}")
  end

  def better_prettyprint(something) do
    IO.puts("The type of (#{something}) is #{BetterUtility.type(something)}")
  end
end

Example.prettyprint("a string")

# instead of the above approach we can use protocols !

defprotocol BetterUtility do
  @spec type(t) :: String.t()
  def type(value)
end

# now each type can implement this interface where they are
defimpl BetterUtility, for: BitString do
  def type(_), do: "string"
end

defimpl BetterUtility, for: Integer do
  def type(_), do: "integer"
end

Example.better_prettyprint("hello world")

# nb: a common interface to implement is String.Chars to implement to_string/1

defprotocol Size do
  @doc "Return the __precalculated__ size (and not the length!) of a data structure"
  def size(data)
end

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end

defmodule SizePrinter do
  def print(value) do
    IO.puts("the size of '#{value}' is #{Size.size(value)}")
  end
end

defimpl String.Chars, for: Tuple do
  def to_string(tuple), do: tuple |> Tuple.to_list |> inspect()
end

defimpl String.Chars, for: Map do
  def to_string(map), do: map |> Map.to_list |> inspect()
end

SizePrinter.print("foo")
SizePrinter.print({:ok, "info"})
SizePrinter.print(%{label: "some label"})

# sometimes you want to derive the protocol for multiple types at once

defimpl Size, for: Any do
  # it's a dumb fallback, but better than a runtime error sometimes
  def size(_), do: 0
end

defmodule User do # imagine this should implement size for some reason
  @derive[Size]
  defstruct [:name, :age]
end

defimpl String.Chars, for: User do
  def to_string(user), do: "#{user.name}, #{user.age} years old"
end

# vvv should work, but cannot refer to Struct created in this file :(
# SizePrinter.print(%User{name: "Tim", age: 38})
#
# a bit more about built-in protocols
# the Enumerable protocol is quite useful, used by the Enum module

# here we use lists but we could use any kind of Enumerable struct
Enum.map([1, 2, 3], fn x -> x * 2 end)
Enum.reduce(1..3, 0, fn x, acc -> x + acc end)

# a little more about the String.Chars protocol
IO.puts("the to_string/1 takes anything implementing String.Chars and returns a String")
IO.puts("for example, this is the result of stringifying '#{inspect(:hello)}' -- #{to_string(:hello)}")
