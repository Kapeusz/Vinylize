defmodule Vinylize.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Vinylize.Catalog` context.
  """

  @doc """
  Generate a unique product sku.
  """
  def unique_product_sku, do: System.unique_integer([:positive])

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        category: 42,
        image: "some image",
        is_seasonal: true,
        name: "some name",
        pack_size: 42,
        price: 120.5,
        sku: unique_product_sku()
      })
      |> Vinylize.Catalog.create_product()

    product
  end
end
