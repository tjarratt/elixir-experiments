defmodule Set do
  defstruct size: 0, elements: []

  def new do; %Set{} end

  def new(list) do
    %Set{size: length(list), elements: list}
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
end
