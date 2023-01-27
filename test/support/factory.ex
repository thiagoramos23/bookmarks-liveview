defmodule Bookmarks.Factory do
  use ExMachina.Ecto, repo: Bookmarks.Repo

  alias Bookmarks.Accounts.User
  alias Bookmarks.Markers.Bookmark

  def bookmark_factory do
    %Bookmark{
      name: "Test",
      type: :blog,
      favorite: false,
      url: "thiagoramos.me",
      user: build(:user)
    }
  end

  def user_factory do
    current_pass = sequence(:name, &"Aa12345678912#{&1}")
    hashed_pass = Argon2.hash_pwd_salt(current_pass)

    %User{
      email: sequence(:email, &"email-#{&1}@thiagoramos.me"),
      password: current_pass,
      hashed_password: hashed_pass,
      confirmed_at: NaiveDateTime.utc_now()
    }
  end
end
