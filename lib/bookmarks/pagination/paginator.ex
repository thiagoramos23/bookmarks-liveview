defmodule Bookmarks.Pagination.Paginator do
  import Ecto.Query
  alias Bookmarks.Repo

  defmodule Page do
    defstruct [:page, :data, :size, :total]
  end

  @spec call(Ecto.Query.t(), map()) :: Page.t()
  def call(query, opts \\ %{}) do
    page = Map.get(opts, :page, 1) || 1
    limit = Map.get(opts, :size, 1000)
    preloads = Map.get(opts, :preloads, [])

    final_query =
      from result in query,
        limit: ^limit,
        offset: ^((page - 1) * limit),
        preload: ^preloads

    total = Repo.aggregate(query, :count)
    data = Repo.all(final_query)

    %Page{page: page, data: data, size: limit, total: total}
  end
end
