defmodule Bookmarks.MarkersTest do
  use Bookmarks.DataCase

  alias Bookmarks.Markers
  alias Bookmarks.Pagination.Paginator.Page

  setup do
    bookmark = insert(:bookmark)
    %{bookmark: bookmark}
  end

  describe "bookmarks" do
    alias Bookmarks.Markers.Bookmark

    @invalid_attrs %{favorite: nil, name: nil, type: nil, url: nil}
    @valid_attrs %{favorite: true, name: "Test", type: :blog, url: "thiagoramos.me"}

    test "list_bookmarks_by_user/3 returns all bookmarks for a user", %{bookmark: bookmark} do
      assert %{data: [returned_bookmark], page: 1} =
               Markers.list_bookmarks_by_user(bookmark.user, bookmark.type)

      assert bookmark.id == returned_bookmark.id
    end

    test "get_bookmark!/1 returns the bookmark with given id", %{bookmark: bookmark} do
      returned_bookmark = Markers.get_bookmark!(bookmark.id)
      assert returned_bookmark.id == bookmark.id
    end

    test "create_bookmark/1 with valid data creates a bookmark", %{bookmark: bookmark} do
      valid_attrs = %{
        favorite: true,
        user_id: bookmark.user_id,
        name: "some name",
        type: "read_it_later",
        url: "some url"
      }

      assert {:ok, %Bookmark{} = bookmark} = Markers.create_bookmark(valid_attrs)
      assert bookmark.favorite == true
      assert bookmark.name == "some name"
      assert bookmark.type == :read_it_later
      assert bookmark.url == "some url"
      assert bookmark.user_id == user.id
    end

    test "create_bookmark/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Markers.create_bookmark(@invalid_attrs)
    end

    test "update_bookmark/2 with valid data updates the bookmark", %{bookmark: bookmark} do
      update_attrs = %{
        favorite: false,
        user_id: bookmark.user_id,
        name: "Google",
        type: "read_it_later",
        url: "https://www.google.com"
      }

      assert {:ok, %Bookmark{} = bookmark} = Markers.update_bookmark(bookmark, update_attrs)
      assert bookmark.favorite == false
      assert bookmark.name == "Google"
      assert bookmark.type == :read_it_later
      assert bookmark.url == "https://www.google.com"
    end

    test "update_bookmark/2 with invalid data returns error changeset", %{bookmark: bookmark} do
      assert {:error, %Ecto.Changeset{}} = Markers.update_bookmark(bookmark, @invalid_attrs)
      assert Markers.get_bookmark!(bookmark.id).id == bookmark.id
    end

    test "delete_bookmark/1 deletes the bookmark", %{bookmark: bookmark} do
      assert {:ok, %Bookmark{}} = Markers.delete_bookmark(bookmark)
      assert_raise Ecto.NoResultsError, fn -> Markers.get_bookmark!(bookmark.id) end
    end

    test "change_bookmark/1 returns a bookmark changeset", %{bookmark: bookmark} do
      assert %Ecto.Changeset{} = Markers.change_bookmark(bookmark)
    end
  end
end
