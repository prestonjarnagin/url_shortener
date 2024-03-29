defmodule Url.Cache do
  use GenServer
  alias Url.Shorteners

  # Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def insert_url(url) do
    GenServer.call(__MODULE__, {:insert_url, url})
  end

  def get_url(url) do
    {:ok, url} = GenServer.call(__MODULE__, {:get_url, url})
    url
  end

  # Server Process
  def init(state) do
    {:ok, state, {:continue, :load_urls}}
  end

  def handle_call({:insert_url, url}, _from, state) do
    ConCache.put(:cache, url.id, url.url)
    {:reply, {:ok, url}, state}
  end

  def handle_call({:get_url, url}, _from, state) do
    reply = ConCache.get(:cache, url)
    {:reply, {:ok, reply}, state}
  end

  def handle_continue(:load_urls, state) do
    urls = Shorteners.list_urls()
    Enum.each(urls, fn url ->
      ConCache.put(:cache, url.id, url.url)
    end)
    {:noreply, state}
  end

end
