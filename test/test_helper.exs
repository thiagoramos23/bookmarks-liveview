ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Bookmarks.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)
