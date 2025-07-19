defmodule StcpStopsWeb.PageController do
  use StcpStopsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
