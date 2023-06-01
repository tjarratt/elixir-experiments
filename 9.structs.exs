my_map = %{a: 42, b: 11}
IO.puts "reading a value from a map #{my_map[:a]}"

updated_map = %{my_map | a: 666}
IO.puts "we can extend maps too : #{updated_map[:a]}"

defmodule Person do
  defstruct name: "John", age: 69
end

# cannot be invoked in the same file, sadly
# person = %Person{}
# person.name -> returns "John"
#
# jane = %{person | name: "Jane"}
# jane.name -> returns "Jane"
# person.name -> still returns "John"
# 
# %{jane | whoopsie: "this won't work"
#          ^ fails b/c whoopsie was not a defined attribute
#
# b/c structs are bare maps underneath we can do this
# 

