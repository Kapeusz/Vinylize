defmodule Vinylize.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :parent_id, :integer, default: "0", null: false

      timestamps()
    end
  end
end
