defmodule Vinylize.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :float
      add :sku, :integer
      add :is_seasonal, :boolean, default: false, null: false
      add :image, :string
      add :pack_size, :integer
      add :category, :integer

      timestamps()
    end

    create unique_index(:products, [:sku])
  end
end
