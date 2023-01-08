defmodule Bookmarks.MarkersTest do
  use Bookmarks.DataCase

  alias Bookmarks.Markers

  describe "bookmarks" do
    alias Bookmarks.Markers.Bookmark

    import Bookmarks.MarkersFixtures

    @invalid_attrs %{favorite: nil, name: nil, type: nil, url: nil}

    test "list_bookmarks/0 returns all bookmarks" do
      bookmark = bookmark_fixture()
      assert Markers.list_bookmarks() == [bookmark]
    end

    test "get_bookmark!/1 returns the bookmark with given id" do
      bookmark = bookmark_fixture()
      assert Markers.get_bookmark!(bookmark.id) == bookmark
    end

    test "create_bookmark/1 with valid data creates a bookmark" do
      valid_attrs = %{favorite: true, name: "some name", type: "some type", url: "some url"}

      assert {:ok, %Bookmark{} = bookmark} = Markers.create_bookmark(valid_attrs)
      assert bookmark.favorite == true
      assert bookmark.name == "some name"
      assert bookmark.type == "some type"
      assert bookmark.url == "some url"
    end

    test "create_bookmark/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Markers.create_bookmark(@invalid_attrs)
    end

    test "update_bookmark/2 with valid data updates the bookmark" do
      bookmark = bookmark_fixture()
      update_attrs = %{favorite: false, name: "some updated name", type: "some updated type", url: "some updated url"}

      assert {:ok, %Bookmark{} = bookmark} = Markers.update_bookmark(bookmark, update_attrs)
      assert bookmark.favorite == false
      assert bookmark.name == "some updated name"
      assert bookmark.type == "some updated type"
      assert bookmark.url == "some updated url"
    end

    test "update_bookmark/2 with invalid data returns error changeset" do
      bookmark = bookmark_fixture()
      assert {:error, %Ecto.Changeset{}} = Markers.update_bookmark(bookmark, @invalid_attrs)
      assert bookmark == Markers.get_bookmark!(bookmark.id)
    end

    test "delete_bookmark/1 deletes the bookmark" do
      bookmark = bookmark_fixture()
      assert {:ok, %Bookmark{}} = Markers.delete_bookmark(bookmark)
      assert_raise Ecto.NoResultsError, fn -> Markers.get_bookmark!(bookmark.id) end
    end

    test "change_bookmark/1 returns a bookmark changeset" do
      bookmark = bookmark_fixture()
      assert %Ecto.Changeset{} = Markers.change_bookmark(bookmark)
    end
  end
end
