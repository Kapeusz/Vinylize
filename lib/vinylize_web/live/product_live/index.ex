defmodule VinylizeWeb.ProductLive.Index do
  use VinylizeWeb, :live_view

  alias Vinylize.Catalog
  alias Vinylize.Catalog.Product

  @impl true
  def mount(_params, _session, socket) do
    Catalog.subscribe()
    changeset = Catalog.change_product(%Product{})
    products = Catalog.list_products()
    categories = Catalog.list_alphabetical_categories()

    {:ok, assign(socket, changeset: changeset, products: products, categories: categories)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Catalog.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Catalog.get_product!(id)
    {:ok, _} = Catalog.delete_product(product)

    {:noreply, assign(socket, :products, list_products())}
  end

  @impl true
  def handle_info({Products, [:product | _], _}, socket) do
    products = Catalog.list_products()
    {:noreply, assign(socket, products: products)}
  end

  defp list_products do
    Catalog.list_products()
  end
end
