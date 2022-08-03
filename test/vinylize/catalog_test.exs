defmodule Vinylize.CatalogTest do
  use Vinylize.DataCase

  alias Vinylize.Catalog

  describe "products" do
    alias Vinylize.Catalog.Product

    import Vinylize.CatalogFixtures

    @invalid_attrs %{category: nil, image: nil, is_seasonal: nil, name: nil, pack_size: nil, price: nil, sku: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{category: 42, image: "some image", is_seasonal: true, name: "some name", pack_size: 42, price: 120.5, sku: 42}

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.category == 42
      assert product.image == "some image"
      assert product.is_seasonal == true
      assert product.name == "some name"
      assert product.pack_size == 42
      assert product.price == 120.5
      assert product.sku == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{category: 43, image: "some updated image", is_seasonal: false, name: "some updated name", pack_size: 43, price: 456.7, sku: 43}

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.category == 43
      assert product.image == "some updated image"
      assert product.is_seasonal == false
      assert product.name == "some updated name"
      assert product.pack_size == 43
      assert product.price == 456.7
      assert product.sku == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end
end
