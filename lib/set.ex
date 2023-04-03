defmodule Set do
  defstruct empty: true

  def new do
    %Set{}
  end

  def empty(set) do
    set.empty
  end
end
