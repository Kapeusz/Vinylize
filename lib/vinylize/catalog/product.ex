defmodule Vinylize.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :image, :string
    field :is_seasonal, :boolean, default: false
    field :name, :string
    field :pack_size, :integer
    field :price, :float
    field :sku, :integer

    belongs_to :category, Vinylize.Catalog.Category

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :sku, :is_seasonal, :image, :pack_size, :category_id])
    |> validate_required([:name, :price, :sku, :is_seasonal, :image, :pack_size, :category_id])
    |> unique_constraint(:sku)
  end
end
