defmodule Vinylize.Repo.Migrations.ChangeDefaultValueParentIdCategoryTable do
  use Ecto.Migration

  def change do
    alter table(:categories) do
      modify :parent_id, :integer, default: "1", null: false
    end
  end
end
