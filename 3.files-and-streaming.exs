stream = File.stream!("test-fixture")

IO.puts Enum.take(stream, 10)
