defmodule SetTest do
  use ExUnit.Case
  doctest Set

  setup_all do
    {:ok,
     empty: Set.new(),
     one: Set.new() |> Set.add(1),
     many: Set.new() |> Set.add(1) |> Set.add(2) |> Set.add(3)}
  end

  test "emptiness", state do
    assert Set.empty(state[:empty]) === true
    assert Set.empty(state[:one]) === false
    assert Set.empty(state[:many]) === false
  end

  test "size", state do
    assert Set.size(state[:empty]) === 0
    assert Set.size(state[:one]) === 1
    assert Set.size(state[:many]) > 1
  end

  test "contains", state do
    assert Set.contains(state[:empty], 1) === false
    assert Set.contains(state[:empty], 2) === false
    assert Set.contains(state[:one], 1) === true
    assert Set.contains(state[:one], 2) === false
    assert Set.contains(state[:many], 1) === true
    assert Set.contains(state[:many], 2) === true
  end

  test "remove" do
    set =
      Set.new()
      |> Set.add(1)
      |> Set.add(2)
      |> Set.add(3)
      |> Set.remove(2)

    assert Set.size(set) === 2
    assert Set.contains(set, 1) === true
    assert Set.contains(set, 2) === false
    assert Set.contains(set, 3) === true
  end

  test "ignores duplicates" do
    set = Set.new() |> Set.add(1) |> Set.add(1)

    assert Set.size(set) === 1
  end
end
