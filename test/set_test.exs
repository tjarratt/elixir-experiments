defmodule SetTest do
  use ExUnit.Case
  doctest Set

  test "emptiness" do
    assert Set.empty(Set.new) === true
  end
end
