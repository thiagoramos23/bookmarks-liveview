defmodule Bookmarks.Factory do
  use ExMachina.Ecto, repo: Bookmarks.Repo

  alias Bookmarks.Markers.Bookmark
  alias Bookmarks.Accounts.User

  @password "simple_user_password"

  def user_factory do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      hashed_password: Bcrypt.hash_pwd_salt(@password),
      confirmed_at: DateTime.truncate(DateTime.utc_now(), :second)
    }
  end

  def bookmark_factory do
    %Bookmark{
      name: sequence(:name, &"Bookmark #{&1}"),
      type: :blog,
      url: "https://www.google.com",
      user: build(:user)
    }
  end
end
