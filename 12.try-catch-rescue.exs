# elixir has three error mechanisms
#
# errors
# throws
# exits

# All about Errors
#

# this would raise an ArithmeticError
raises_arithmetic_error = fn () -> :foo + 1 end

try do
  raises_arithmetic_error.()
rescue 
  ArithmeticError -> IO.puts("We can rescue ArithmeticError \\o/")
  _ -> IO.puts("failed to rescue ArithmeticError")
end

# you can also raise errors in your own code
raises_runtime_error = fn () -> raise "oops" end

try do
  raises_runtime_error.()
rescue
  RuntimeError -> IO.puts("We can rescue RuntimeErrors too \\o/")
  _ -> IO.puts("failed to rescue RuntimeError")
end

IO.puts("")

# raise specific error types if you like
raises_argument_error = fn () -> raise ArgumentError, message: "NOPE" end

try do
  raises_argument_error.()
rescue
  ArgumentError -> IO.puts("We can raise and rescue specific Error types \\o/")
  _ -> IO.puts("failed to rescue ArgumentError")
end

IO.puts("")

# create a custom error type by defining a module and `defexception`
defmodule CoolError do
  defexception message: "cool cats create custom error types"
end

raises_cool_error = fn () -> raise CoolError, message: "NOPE" end

try do
  raises_cool_error.()
rescue
  CoolError -> IO.puts("We can raise custom Error types \\o/")
  _ -> IO.puts("failed to rescue CoolError")
end

IO.puts("")

# most elixir functions return a tuple of {status, details}
# but if you call a BANG ! method then it will raise

raises_file_error = fn () -> File.read!("does/not/exist") end

try do
  raises_file_error.()
rescue 
  File.Error -> IO.puts("You can catch errors from bang! methods such as File.read!")
  _ -> IO.puts("failed to rescue File.Error")
end

IO.puts("")

# in some cases you may want to re-raise errors (useful if you want a wrapper for logger or metrics)
re_raises_cool_error = fn () -> 
  try do
    raises_cool_error.()
  rescue
    e in CoolError -> 
      IO.puts("rescued and re-raising CoolError")
      reraise(e, __STACKTRACE__)

    _ -> IO.puts("Failed to rescue from CoolError")
  end
end

try do
  re_raises_cool_error.()
rescue
  CoolError -> IO.puts("... finally rescued CoolError at call-site \\o/")
  _ -> IO.puts("Failed to rescue re-raised CoolError :(")
end

IO.puts("")

# you can also throw values in Elixir
# This is useful for situations where it is not possible
# to retrieve a value unless by using throw and catch
# (hopefully these are rare)

# imagine that Enum.find did not exist, we would need to jump through hoops

find_via_iteration = fn () -> 
  Enum.each(-50..50, fn (x) ->
    if rem(x, 13) == 0, do: throw(x)
  end)
end

try do
  find_via_iteration.()
catch
  x -> IO.puts("The value divisible by 13 is #{x}")
end

# luckily there is a better way to do this
IO.puts("The first value divisible by 13 is ... #{Enum.find(-50..50, &(rem(&1, 13) == 0))}")
IO.puts("")

# Exits are the last type of "error" we have in elixir
# When a process dies it sends an exit signal

try do 
  exit(1)
catch 
  :exit, 1 -> IO.puts("Successfully caught from an exit(1) call, nice")
  _ -> IO.puts("Could not catch an exit() call :(")
end

IO.puts("")

# Else can be used with a try / rescue block

describe_size_of_inverse = fn (x) -> 
  try do 
    1 / x
  rescue 
    ArithmeticError -> :infinity
  else
    y when y < 1 and y > -1 -> :small
    _ -> :large
  end
end

case describe_size_of_inverse.(0) do
  :infinity -> IO.puts("We can use an else clause in a try/rescue block")
  _ -> IO.puts("Failed to use else clause with try/rescue")
end

