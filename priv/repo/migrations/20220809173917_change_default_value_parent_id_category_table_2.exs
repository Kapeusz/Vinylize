defmodule Vinylize.Repo.Migrations.ChangeDefaultValueParentIdCategoryTable2 do
  use Ecto.Migration

  def change do
    alter table(:categories) do
      modify :parent_id, :integer
    end
  end
end
