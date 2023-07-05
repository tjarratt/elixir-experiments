defmodule SendingProcess do
  def run(pid) do
    send(pid, :ping)
  end
end
