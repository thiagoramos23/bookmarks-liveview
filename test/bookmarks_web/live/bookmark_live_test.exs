defmodule BookmarksWeb.BookmarkLiveTest do
  use BookmarksWeb.ConnCase
  import Phoenix.LiveViewTest

  setup :register_and_log_in_user

  @invalid_attrs %{url: nil, name: nil}

  describe "Index" do
    test "lists all bookmarks", %{conn: conn, user: user} do
      bookmark = insert(:bookmark, type: :read_it_later, user: user)
      {:ok, _index_live, html} = live(conn, ~p"/bookmarks?type=read_it_later")

      assert html =~ "Read It Later"
      assert html =~ bookmark.name
      assert html =~ bookmark.url
    end

    test "saves new bookmark", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, ~p"/bookmarks")

      assert index_live |> element("a", "Add New Bookmark") |> render_click() =~
               "New Bookmark"

      assert_patch(index_live, ~p"/bookmarks/new")

      assert index_live
             |> form("#bookmark-form", bookmark: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bookmark-form",
          bookmark:
            params_for(:bookmark,
              name: "Testing",
              url: "https://www.google.com",
              type: :read_it_later,
              user: user
            )
        )
        |> render_submit()
        |> follow_redirect(conn, ~p"/bookmarks?type=read_it_later")

      assert html =~ "Bookmark created successfully"
      assert html =~ "Testing"
    end

    test "updates bookmark in listing", %{conn: conn, user: user} do
      bookmark = insert(:bookmark, type: :read_it_later, user: user)
      {:ok, index_live, _html} = live(conn, ~p"/bookmarks?type=read_it_later")

      assert index_live |> element("#bookmarks-#{bookmark.id} a", "Edit") |> render_click() =~
               "Edit Bookmark"

      assert_patch(index_live, ~p"/bookmarks/#{bookmark}/edit")

      assert index_live
             |> form("#bookmark-form", bookmark: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bookmark-form", bookmark: params_for(:bookmark, name: "Testing again"))
        |> render_submit()
        |> follow_redirect(conn, ~p"/bookmarks?type=read_it_later")

      assert html =~ "Bookmark updated successfully"
      assert html =~ "Testing again"
    end

    test "deletes bookmark in listing", %{conn: conn, user: user} do
      bookmark = insert(:bookmark, type: :read_it_later, user: user)
      {:ok, index_live, _html} = live(conn, ~p"/bookmarks")

      assert index_live |> element("#bookmarks-#{bookmark.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bookmark-#{bookmark.id}")
    end
  end

  describe "Show" do
    test "displays bookmark", %{conn: conn, user: user} do
      bookmark = insert(:bookmark, type: :read_it_later, user: user)
      {:ok, _show_live, html} = live(conn, ~p"/bookmarks/#{bookmark}")

      assert html =~ "Show Bookmark"
      assert html =~ bookmark.name
    end

    test "updates bookmark within modal", %{conn: conn, user: user} do
      bookmark = insert(:bookmark, type: :read_it_later, user: user)
      {:ok, show_live, _html} = live(conn, ~p"/bookmarks/#{bookmark}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bookmark"

      assert_patch(show_live, ~p"/bookmarks/#{bookmark}/show/edit")

      assert show_live
             |> form("#bookmark-form", bookmark: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bookmark-form", bookmark: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/bookmarks/#{bookmark}")

      assert html =~ "Bookmark updated successfully"
      assert html =~ "some updated name"
    end
  end
end
