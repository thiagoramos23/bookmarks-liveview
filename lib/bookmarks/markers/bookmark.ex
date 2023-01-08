defmodule Bookmarks.Markers.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset

  @types [:blog, :read_it_later, :learning, :other]

  schema "bookmarks" do
    field :favorite, :boolean, default: false
    field :name, :string
    field :type, Ecto.Enum, values: @types
    field :url, :string
    belongs_to :user, Bookmarks.Accounts.User

    timestamps()
  end

  def types do
    @types
  end

  @required_fields [:name, :url, :type, :favorite, :user_id]

  @doc false
  def changeset(bookmark, attrs) do
    bookmark
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
