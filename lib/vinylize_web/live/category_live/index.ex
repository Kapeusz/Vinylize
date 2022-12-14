defmodule VinylizeWeb.CategoryLive.Index do
  use VinylizeWeb, :live_view

  alias Vinylize.Catalog
  alias Vinylize.Catalog.Category

  @impl true
  def mount(_params, _session, socket) do
    categories = Catalog.list_alphabetical_categories()


    {:ok, assign(socket, categories: categories)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Category")
    |> assign(:category, Catalog.get_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Category")
    |> assign(:category, %Category{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Categories")
    |> assign(:category, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    category = Catalog.get_category!(id)
    {:ok, _} = Catalog.delete_category(category)

    {:noreply, assign(socket, :categories, list_categories())}
  end

  defp list_categories do
    Catalog.list_categories()
  end

  def parent_category_name(%Category{} = category) do
    Catalog.get_parent_category_id(category)
  end
end
