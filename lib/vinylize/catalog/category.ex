defmodule Vinylize.Catalog.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :parent_id, :integer

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name, :parent_id])
  end
end
