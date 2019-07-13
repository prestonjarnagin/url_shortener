defmodule Url.Shorteners do
  @moduledoc """
  The Shorteners context.
  """

  import Ecto.Query, warn: false
  alias Url.Repo

  alias Url.Shorteners.URL

  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%URL{}, ...]

  """
  def list_urls do
    Repo.all(URL)
  end

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %URL{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(URL, id)

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %URL{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    {:ok, url} =
    %URL{}
    |> URL.changeset(attrs)
    |> Repo.insert()

    Url.Cache.insert_url(url)
    {:ok, url}
  end

  @doc """
  Updates a url.

  ## Examples

      iex> update_url(url, %{field: new_value})
      {:ok, %URL{}}

      iex> update_url(url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_url(%URL{} = url, attrs) do
    url
    |> URL.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a URL.

  ## Examples

      iex> delete_url(url)
      {:ok, %URL{}}

      iex> delete_url(url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_url(%URL{} = url) do
    Repo.delete(url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.

  ## Examples

      iex> change_url(url)
      %Ecto.Changeset{source: %URL{}}

  """
  def change_url(%URL{} = url) do
    URL.changeset(url, %{})
  end
end
