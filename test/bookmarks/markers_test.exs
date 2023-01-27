defmodule Bookmarks.MarkersTest do
  use Bookmarks.DataCase

  alias Bookmarks.Markers
  alias Bookmarks.Pagination.Paginator.Page

  describe "bookmarks" do
    alias Bookmarks.Markers.Bookmark

    @invalid_attrs %{favorite: nil, name: nil, type: nil, url: nil}
    @valid_attrs %{favorite: true, name: "Test", type: :blog, url: "thiagoramos.me"}

    defp bookmark_fixture(attrs \\ @valid_attrs) do
      insert(:bookmark, attrs)
    end

    test "list_bookmarks_by_user/3 returns all bookmarks for the user" do
      user = insert(:user)
      bookmark = bookmark_fixture(%{user: user, type: :blog})
      bookmark_fixture(%{user: user, type: :learning})
      bookmark_fixture(%{user: build(:user)})

      assert %Page{data: [returned_bookmark]} = Markers.list_bookmarks_by_user(user, "blog")

      assert returned_bookmark.name == bookmark.name
      assert returned_bookmark.url == bookmark.url
      assert returned_bookmark.type == bookmark.type
      assert returned_bookmark.user_id == bookmark.user_id
    end

    test "get_bookmark!/1 returns the bookmark with given id" do
      bookmark = bookmark_fixture()
      assert Markers.get_bookmark!(bookmark.id).id == bookmark.id
    end

    test "create_bookmark/1 with valid data creates a bookmark" do
      user = insert(:user)

      valid_attrs = %{
        favorite: true,
        name: "some name",
        type: :blog,
        url: "some url",
        user_id: user.id
      }

      assert {:ok, %Bookmark{} = bookmark} = Markers.create_bookmark(valid_attrs)
      assert bookmark.favorite == true
      assert bookmark.name == "some name"
      assert bookmark.type == :blog
      assert bookmark.url == "some url"
      assert bookmark.user_id == user.id
    end

    test "create_bookmark/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Markers.create_bookmark(@invalid_attrs)
    end

    test "update_bookmark/2 with valid data updates the bookmark" do
      bookmark = bookmark_fixture(%{type: :learning})

      update_attrs = %{
        favorite: false,
        name: "some updated name",
        type: :blog,
        url: "thiagoramos.com"
      }

      assert {:ok, %Bookmark{} = bookmark} = Markers.update_bookmark(bookmark, update_attrs)
      assert bookmark.favorite == false
      assert bookmark.name == "some updated name"
      assert bookmark.type == :blog
      assert bookmark.url == "thiagoramos.com"
    end

    test "update_bookmark/2 with invalid data returns error changeset" do
      bookmark = bookmark_fixture()
      assert {:error, %Ecto.Changeset{}} = Markers.update_bookmark(bookmark, @invalid_attrs)
      assert bookmark.id == Markers.get_bookmark!(bookmark.id).id
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
