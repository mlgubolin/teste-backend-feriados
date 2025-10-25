defmodule HolidayWeb.PageController do
  use HolidayWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
