defmodule UrlWeb.URLController do
  use UrlWeb, :controller

  alias Url.Shorteners
  alias Url.Shorteners.URL

  action_fallback UrlWeb.FallbackController

  def index(conn, _params) do
    urls = Shorteners.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    with {:ok, %URL{} = url} <- Shorteners.create_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def show(conn, %{"id" => id}) do
    url = Shorteners.get_url!(id)
    render(conn, "show.json", url: url)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = Shorteners.get_url!(id)

    with {:ok, %URL{} = url} <- Shorteners.update_url(url, url_params) do
      render(conn, "show.json", url: url)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = Shorteners.get_url!(id)

    with {:ok, %URL{}} <- Shorteners.delete_url(url) do
      send_resp(conn, :no_content, "")
    end
  end

  def short_url_redirect(conn, %{"short_url" => short_url}) do
    {:ok, id} = Base62.decode(short_url)
    url = Shorteners.get_url!(id)
    redirect(conn, external: url.url)
  end
end
