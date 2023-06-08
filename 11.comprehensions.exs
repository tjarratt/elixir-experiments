defmodule Example do
  def present(list) do
    list |> Enum.map(&Integer.to_string/1) |> Enum.join(", ")
  end
end

# we frequently want to loop over an Enumerable
# ... filter out some results
# ... map values onto another type
# ... and yield a new list
# comprehensions are syntactic sugar for this

squared = for n <- [1, 2, 3, 4], do: n * n

IO.puts("the first four square numbers are #{squared |> Example.present}")
IO.puts("")

# along the way we learned an important thing about lists
# remember that lits of integers are basically a string in a low level language like Erlang

abc = [65, 66, 67]
IO.puts("The first three upper case letters are #{abc}")
IO.puts("")
# if you want these to be printed otherwise ... be prepared for some gymnastics as we see above with map and join

# We can use any enumerable on the right-hand side of the generator expression
# look here we can filter a keyword list and generate a new list from it

values = [odd: 1, even: 2, odd: 3, even: 4]
even_squares = for {:even, n} <- values, do: n * n
IO.puts("The squares of the first few even integers is #{even_squares |> Example.present}")

# the list comprehension above supports a filter on {:even, n}

# alternatively we can add a filter to a generator
squares_of_multiples_of_three = for n <- 0..10, rem(n, 3) == 0, do: n * n

IO.puts("The squares of the first few multiples of three are #{squares_of_multiples_of_three |> Example.present}")
IO.puts("")

# we can also use multiple generators to, eg, make a cartesian product
cross_product = for i <- [1,2,3], j <- [1,2,3], do: {i, j}
IO.puts("What's the cartesian product of [1,2,3] with itself ? Why it's...")
IO.inspect(cross_product)
IO.puts("")

# bitstring generators can be useful too if you have to do bit-twiddling
raw_bytes= <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
pixels = for <<r::8, g::8, b::8 <- raw_bytes>>, do: {r, g, b}
IO.puts("checkout these sick pixel values:")
IO.inspect(pixels)
IO.puts("")
# nb: you can mix and match bitstring generators with other generators and filters !

# we can use the into: option to reduce into anything that supports the Collectable protocol
ages = %{"Alice": 35, "Bob": 70}
IO.puts("What is everyone's age ?")
IO.inspect(ages)
IO.puts("suddenly everyone aged overnight !")
IO.inspect(for {name, age} <- ages, into: %{}, do: {name, age * 2})
IO.puts("")

# let's say we want to count the frequency of lower-case letters in a word
input = "AbCabCABc"
lower_case_letters = for <<x <- input>>, x in ?a..?z, do: <<x>>
frequency = Enum.reduce(lower_case_letters, %{}, fn x, acc -> Map.update(acc, x, 1, & &1 + 1) end)
IO.puts("the frequency of letters in '#{input}' is as follows:")
IO.inspect(frequency)

# can also be computed as a list comprension (more performant, as the above iterates the data at least twice)
frequency_better = for <<x <- input>>, x in ?a..?z, reduce: %{} do
  acc -> Map.update(acc, <<x>>, 1, & &1 + 1)
end
IO.puts("another way of calculating frequency using list comprehensions only ...")
IO.inspect(frequency_better)
IO.puts("")

