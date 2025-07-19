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
     |> load_stops()}
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:stop_code, nil)
     |> assign(:loading, false)
     |> assign(:error, "No stop code provided")
     |> assign(:stops, [])}
  end

  @impl true
  def handle_info(:load_stops, socket) do
    {:noreply, load_stops(socket)}
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
      line when line in ["201", "202", "203"] -> "bg-red-500"
      line when line in ["500", "501", "502"] -> "bg-blue-500"
      line when line in ["800", "801", "802", "803"] -> "bg-green-500"
      _ -> "bg-gray-500"
    end
  end
end
