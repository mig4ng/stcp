defmodule StcpStops.StopsAPI do
  @moduledoc """
  API client for fetching STCP bus stop information.
  Adapted from the original StopsAPI to work with Phoenix and Req.
  """

  @doc """
  Fetches bus stops for a given paragem (stop code).
  Returns {:ok, stops} or {:error, reason}.
  """
  def get_stops(paragem) when is_binary(paragem) do
    url =
      "https://www.stcp.pt/pt/widget/post.php?uid=d72242190a22274321cacf9eadc7ec5f&paragem=#{paragem}"

    case Req.get(url, connect_options: [transport_opts: [verify: :verify_none]]) do
      {:ok, %{status: 200, body: body}} ->
        case parse_stops(body) do
          {:ok, stops_lines} -> {:ok, batch_stops(stops_lines)}
          error -> error
        end

      {:ok, %{status: status}} ->
        {:error, "HTTP #{status}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse_stops(html) do
    try do
      case Floki.parse_document(html) do
        {:ok, document} ->
          stops_lines =
            document
            |> Floki.find("div.floatLeft")
            |> Enum.filter(&has_linha_class?/1)
            |> Enum.map(&Floki.text/1)

          {:ok, stops_lines}

        {:error, reason} ->
          {:error, reason}
      end
    rescue
      e -> {:error, e}
    end
  end

  defp has_linha_class?({_tag, attributes, _children}) do
    case List.keyfind(attributes, "class", 0) do
      {"class", class_string} -> String.contains?(class_string, "Linha")
      nil -> false
    end
  end

  defp batch_stops(stops_lines) do
    stops_lines
    |> Enum.drop(3)
    |> Enum.chunk_every(3)
  end
end
