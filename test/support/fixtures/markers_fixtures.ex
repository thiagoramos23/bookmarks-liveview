defmodule Bookmarks.MarkersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bookmarks.Markers` context.
  """

  @doc """
  Generate a bookmark.
  """
  def bookmark_fixture(attrs \\ %{}) do
    {:ok, bookmark} =
      attrs
      |> Enum.into(%{
        favorite: true,
        name: "some name",
        type: "some type",
        url: "some url"
      })
      |> Bookmarks.Markers.create_bookmark()

    bookmark
  end
end
