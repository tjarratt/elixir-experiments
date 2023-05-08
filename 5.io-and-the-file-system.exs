IO.puts("welcome to this program")

response = IO.gets("Would you like to play a game ? (yes or NO)\n") |> String.trim

case String.trim(response, "\n") do
  "yes" -> IO.puts "TOO BAD WE AINT GOT NO GAMES"
  "NO"  -> IO.puts "Great we didn't want to play a game anyway"
  _     -> IO.puts "WHAT DO YOU MEAN by '#{response}' anyway ???"
end

defmodule PreparationForAdventOfCode do
  def not_empty?("") do
    false
  end

  def not_empty?(_) do
    true
  end 
end

IO.puts("now for something completely different")
output = File.read!("integers")
         |> String.split("\n")
         |> Enum.filter(&PreparationForAdventOfCode.not_empty?/1)
         |> Enum.map(&String.to_integer/1)
        
IO.puts(List.last(output))

{:ok, file} = File.open("test-file", [:write])
IO.binwrite(file, "this is the contents of 'test-file'")

File.close(file)

IO.puts(File.read!("test-file"))

case File.read("this/file/does/not/exist") do
  {:ok, _} -> IO.puts("This should never happen")
  {:error, reason} -> IO.puts("The expected file did not exist , the error is (#{reason})")
end

