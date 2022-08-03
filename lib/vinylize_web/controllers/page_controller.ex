defmodule VinylizeWeb.PageController do
  use VinylizeWeb, :controller

  alias Vinylize.Catalog

  def index(conn, _params) do
    seasonal_products = Catalog.list_seasonal_products
    new_conn = assign(conn, :my_seasonal_products, seasonal_products)
    render new_conn, "index.html"
  end
end
