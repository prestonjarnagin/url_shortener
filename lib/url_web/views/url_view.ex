defmodule UrlWeb.URLView do
  use UrlWeb, :view
  alias UrlWeb.URLView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, URLView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    IO.inspect(url)
    %{data: render_one(url, URLView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    short = Base62.encode(url.id)
    %{id: url.id,
      url: url.url,
      short: short}
  end
end
