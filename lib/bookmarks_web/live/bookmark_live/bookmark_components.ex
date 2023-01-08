defmodule BookmarksWeb.BookmarkLive.BookmarkComponents do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  attr :id, :string, required: true
  attr :rows, :list, required: true
  slot :actions

  def search(assigns) do
    ~H"""
    <div class="mt-1">
      <div class="flex items-center">
        <input
          placeholder="Search your bookmarks"
          class="block w-full px-3 py-2 placeholder-gray-400 border border-gray-300 appearance-none rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm mr-2"
        />
        <button class="flex justify-center w-32 px-2 py-2 text-sm font-semibold text-white bg-indigo-500 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-600">
          Search
        </button>
      </div>
    </div>
    """
  end

  def bookmark_table(assigns) do
    ~H"""
    <div class="mt-2 overflow-hidden bg-white sm:rounded-md">
      <ul class="divide-y divide-gray-100">
        <div :for={row <- @rows} id={"#{@id}-#{Phoenix.Param.to_param(row)}"}>
          <.link href={URI.merge("http://", row.url)} target="_blank" class="block">
            <li>
              <div class="flex items-center px-4 pt-2 pb-2 sm:px-6">
                <div class="flex items-center flex-1 min-w-0">
                  <div class="flex-1 min-w-0 px-4">
                    <div class="grid grid-flow-col grid-cols-1">
                      <div class="flex flex-col items-start sm:flex-initial">
                        <p class="mr-4 text-lg font-medium text-indigo-600"><%= row.name %></p>
                        <div class="flex items-center text-gray-500 text-md w-4/5 break-words">
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                          >
                            <path
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              stroke-width="2"
                              d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1"
                            />
                          </svg>
                          <p class="break-all"><%= row.url %></p>
                        </div>
                      </div>
                      <div :if={@actions != []} class="flex items-center justify-self-end">
                        <span :for={action <- @actions}>
                          <%= render_slot(action, row) %>
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </li>
          </.link>
        </div>
      </ul>
    </div>
    """
  end
end
