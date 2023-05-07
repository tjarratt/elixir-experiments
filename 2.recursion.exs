defmodule Recursion do
  def print_multiple_times(message, n) when n > 0 do
    IO.puts(message)
    print_multiple_times(message, n - 1)
  end

  def print_multiple_times(_, 0) do
    :ok
  end
end

defmodule Math do
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end

  def sum_list([head | tail]) do
    sum_list(tail, head)
  end

  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end

Recursion.print_multiple_times("Hello!", 3)
IO.puts Math.sum_list([1,2,3], 0)
IO.puts Math.sum_list([1,2,3])
IO.puts Math.double_each([1,2,3])

