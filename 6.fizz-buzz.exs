defmodule FizzBuzz do
  def generate(upto) do
    1..upto |> Enum.map(&apply_rules/1)
  end

  def apply_rules(number) do
    case { rem(number, 3), rem(number, 5) } do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      _ -> to_string(number)
    end
  end
end

IO.puts (FizzBuzz.generate(20) |> Enum.join(", "))
