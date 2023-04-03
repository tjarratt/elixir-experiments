defmodule SetTest do
  use ExUnit.Case
  doctest Set

  test "emptiness" do
    assert Set.empty(Set.new) === true
    assert Set.empty(Set.new([1])) == false
    assert Set.empty(Set.new([1, 2])) == false
  end

end
