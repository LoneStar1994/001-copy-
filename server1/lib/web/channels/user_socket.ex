defmodule Server1.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "server:*", Server1.Channel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  def connect(_params, socket) do
    {:ok, socket}
  end
  
  def id(_socket), do: nil

end
