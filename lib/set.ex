defmodule Set do
  defstruct size: 0, elements: []

  def new do
    %Set{}
  end

  def add(set, element) do
    case Enum.member?(set.elements, element) do
      true ->
        set

      false ->
        %Set{
          size: set.size + 1,
          elements: [element | set.elements]
        }
    end
  end

  def empty(set) do
    set.size === 0
  end

  def size(set) do
    set.size
  end

  def contains(set, element) do
    element in set.elements
  end

  def remove(set, element) do
    %Set{
      size: set.size - 1,
      elements: List.delete(set.elements, element)
    }
  end
end
