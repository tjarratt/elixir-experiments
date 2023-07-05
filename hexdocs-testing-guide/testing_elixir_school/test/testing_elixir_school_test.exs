defmodule TestingElixirSchoolTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TestingElixirSchool

  test "greets the world" do
    assert TestingElixirSchool.hello() == :world
  end

  test "saying goodbye" do
    refute TestingElixirSchool.goodbye() == :world
  end

  test "raises" do
    assert_raise ArithmeticError, fn -> 1 + :whoops end
  end

  test "receives a ping" do
    SendingProcess.run(self())

    assert_received :ping
  end

  test "capturing IO" do
    captured = capture_io(fn -> Printer.print() end) 
    assert captured == "Hello World\n"
  end
end

defmodule TestSetupExamples do
  use ExUnit.Case

  setup_all do
    {:ok, recipient: :world}
  end

  test "greets", state do
    assert TestingElixirSchool.hello() == state[:recipient]
  end
end
