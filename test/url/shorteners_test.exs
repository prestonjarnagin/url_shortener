defmodule Url.ShortenersTest do
  use Url.DataCase

  alias Url.Shorteners

  describe "urls" do
    alias Url.Shorteners.URL

    @valid_attrs %{url: "some url"}
    @update_attrs %{url: "some updated url"}
    @invalid_attrs %{url: nil}

    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shorteners.create_url()

      url
    end

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Shorteners.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Shorteners.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      assert {:ok, %URL{} = url} = Shorteners.create_url(@valid_attrs)
      assert url.url == "some url"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shorteners.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      assert {:ok, %URL{} = url} = Shorteners.update_url(url, @update_attrs)
      assert url.url == "some updated url"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Shorteners.update_url(url, @invalid_attrs)
      assert url == Shorteners.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %URL{}} = Shorteners.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Shorteners.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Shorteners.change_url(url)
    end
  end
end
