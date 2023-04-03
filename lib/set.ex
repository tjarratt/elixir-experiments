defmodule Set do
  defstruct empty: true, size: 0

  def new do; %Set{} end

  def new(list) do
    %Set{empty: false, size: length(list)}
  end

  def empty(set) do
    set.empty
  end

  def size(set) do
    set.size
  end
end
