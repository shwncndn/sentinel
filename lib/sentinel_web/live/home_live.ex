defmodule SentinelWeb.HomeLive do
  use SentinelWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    Sentinel Home
    """
  end
end
