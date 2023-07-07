defmodule Bookmarks.Markers do
  @moduledoc """
  The Markers context.
  """

  import Ecto.Query, warn: false
  alias Bookmarks.Repo

  alias Bookmarks.Markers.Bookmark
  alias Bookmarks.Markers.Finders.FindBookmark

  @doc """
  Returns the list of favorite bookmarks for the user.

  ## Examples

      iex> list_favorite_bookmarks_by_user(user)
      [%Bookmark{}, ...]

  """
  def list_favorite_bookmarks_by_user(user, page \\ 1) do
    FindBookmark.find(%{user_id: user.id, favorite: true}, %{page: page, preloads: [:user]})
  end

  @doc """
  Returns the list of bookmarks for the user.

  ## Examples

      iex> list_bookmarks_by_user(user)
      [%Bookmark{}, ...]

  """
  def list_bookmarks_by_user(user, type, page \\ 1) do
    FindBookmark.find(%{user_id: user.id, type: type}, %{page: page, preloads: [:user]})
  end

  @doc """
  Returns the list of bookmarks that matches the search term for the user.

  ## Examples

      iex> list_searched_bookmarks_by_user(user, "Test")
      [%Bookmark{}, ...]

  """
  def list_searched_bookmarks_by_user(user, search, page \\ 1) do
    FindBookmark.find(%{user_id: user.id, name: search}, %{page: page, preloads: [:user]})
  end

  @doc """
  Gets a single bookmark.

  Raises `Ecto.NoResultsError` if the Bookmark does not exist.

  ## Examples

      iex> get_bookmark!(123)
      %Bookmark{}

      iex> get_bookmark!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bookmark!(id), do: Repo.get!(Bookmark, id)

  @doc """
  Creates a bookmark.

  ## Examples

      iex> create_bookmark(%{field: value})
      {:ok, %Bookmark{}}

      iex> create_bookmark(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bookmark(attrs \\ %{}) do
    %Bookmark{}
    |> Bookmark.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bookmark.

  ## Examples

      iex> update_bookmark(bookmark, %{field: new_value})
      {:ok, %Bookmark{}}

      iex> update_bookmark(bookmark, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bookmark(%Bookmark{} = bookmark, attrs) do
    bookmark
    |> Bookmark.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bookmark.

  ## Examples

      iex> delete_bookmark(bookmark)
      {:ok, %Bookmark{}}

      iex> delete_bookmark(bookmark)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bookmark(%Bookmark{} = bookmark) do
    Repo.delete(bookmark)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bookmark changes.

  ## Examples

      iex> change_bookmark(bookmark)
      %Ecto.Changeset{data: %Bookmark{}}

  """
  def change_bookmark(%Bookmark{} = bookmark, attrs \\ %{}) do
    Bookmark.changeset(bookmark, attrs)
  end
end
