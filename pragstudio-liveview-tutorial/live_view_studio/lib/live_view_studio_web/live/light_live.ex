defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  # first callback invoked when a request comes in through the router
  # it's here that we assign the initial state of the LiveViewProcess
  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>
      <button phx-click="off">
        <img src="/images/light-off.svg" />
      </button>
      <button phx-click="down">
        <img src="/images/down.svg" />
      </button>
      <button phx-click="random">
        <img src="/images/fire.svg" />
      </button>
      <button phx-click="up">
        <img src="/images/up.svg" />
      </button>
      <button phx-click="on">
        <img src="/images/light-on.svg" />
      </button>
    </div>
    """
  end

  def handle_event("on", _payload, socket) do
    socket = assign(socket, brightness: 100)
    {:noreply, socket}
  end

  def handle_event("off", _payload, socket) do
    socket = assign(socket, brightness: 0)
    {:noreply, socket}
  end

  def handle_event("up", _payload, socket) do
    brightness = min(socket.assigns.brightness + 10, 100)
    socket = assign(socket, brightness: brightness)
    {:noreply, socket}
  end

  def handle_event("down", _payload, socket) do
    socket = update(socket, :brightness, &(max(&1 - 10, 0)))
    {:noreply, socket}
  end

  def handle_event("random", _payload, socket) do
    socket = assign(socket, brightness: Enum.random(0..100))
    {:noreply, socket}
  end
end
