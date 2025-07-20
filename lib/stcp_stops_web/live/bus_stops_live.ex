defmodule StcpStopsWeb.BusStopsLive do
  use StcpStopsWeb, :live_view

  @impl true
  def mount(%{"stop_code" => stop_code}, _session, socket) do
    {:ok,
     socket
     |> assign(:stop_code, stop_code)
     |> assign(:loading, true)
     |> assign(:error, nil)
     |> assign(:stops, [])
     |> assign(:show_form, false)
     |> load_stops()}
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:stop_code, nil)
     |> assign(:loading, false)
     |> assign(:error, nil)
     |> assign(:stops, [])
     |> assign(:show_form, true)}
  end

  @impl true
  def handle_info(:load_stops, socket) do
    {:noreply, load_stops(socket)}
  end

  @impl true
  def handle_event("go_to_stop", %{"stop_code" => stop_code}, socket) do
    stop_code = String.trim(stop_code)

    if stop_code != "" do
      {:noreply, push_navigate(socket, to: "/#{stop_code}")}
    else
      {:noreply, socket}
    end
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  defp load_stops(socket) do
    stop_code = socket.assigns.stop_code

    case StcpStops.StopsAPI.get_stops(stop_code) do
      {:ok, stops} ->
        socket
        |> assign(:loading, false)
        |> assign(:error, nil)
        |> assign(:stops, stops)

      {:error, reason} ->
        socket
        |> assign(:loading, false)
        |> assign(:error, "Failed to load stops: #{inspect(reason)}")
        |> assign(:stops, [])
    end
  end

  defp format_time(time_str) when is_binary(time_str) do
    case String.trim(time_str) do
      "" -> "N/A"
      time -> time
    end
  end

  defp format_time(_), do: "N/A"

  defp get_line_color(line) do
    case String.trim(line) do
      line -> "bg-gray-500 linha_#{String.downcase(line)}"
      _ -> "bg-gray-500"
    end
  end
end
