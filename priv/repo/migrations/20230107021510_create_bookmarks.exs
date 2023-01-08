defmodule Bookmarks.Repo.Migrations.CreateBookmarks do
  use Ecto.Migration

  def change do
    create table(:bookmarks) do
      add :name, :string
      add :url, :string
      add :type, :string
      add :favorite, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:bookmarks, [:user_id])
  end
end
