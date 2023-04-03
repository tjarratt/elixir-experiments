defmodule Set do
  defstruct size: 0

  def new do; %Set{} end

  def new(list) do
    %Set{size: length(list)}
  end

  def empty(set) do
    set.size === 0
  end

  def size(set) do
    set.size
  end
end
