defmodule BookmarksWeb.BookmarkLive.Index do
  use BookmarksWeb, :live_view
  import BookmarksWeb.BookmarkLive.BookmarkComponents

  alias Bookmarks.Markers
  alias Bookmarks.Markers.Bookmark

  @empty ""

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:bookmarks, list_bookmarks(socket.assigns.current_user, "read_it_later", 1))
     |> assign(:changeset, Markers.change_bookmark(%Bookmark{}))
     |> assign(:type, "read_it_later")
     |> assign(:query_term, @empty)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bookmark")
    |> assign(:bookmark, Markers.get_bookmark!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bookmark")
    |> assign(:bookmark, %Bookmark{})
  end

  defp apply_action(socket, :index, %{"type" => type}) do
    socket
    |> assign(:type, type)
    |> assign(:bookmarks, list_bookmarks(socket.assigns.current_user, type, 1))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bookmarks")
    |> assign(:bookmark, nil)
    |> assign(:bookmarks, [])
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bookmark = Markers.get_bookmark!(id)
    {:ok, _} = Markers.delete_bookmark(bookmark)

    {:noreply, assign(socket, :bookmarks, list_bookmarks(socket.assigns.current_user, :blog, 1))}
  end

  def handle_event("search", %{"search" => query_term}, socket) do
    %{data: data} =
      Markers.list_searched_bookmarks_by_user(socket.assigns.current_user, query_term, 1)

    {:noreply,
     socket
     |> assign(:type, @empty)
     |> assign(:bookmarks, data)
     |> assign(:query_term, query_term)}
  end

  defp list_bookmarks(user, type, page) do
    %{data: data} = Markers.list_bookmarks_by_user(user, type, page)
    data
  end
end
