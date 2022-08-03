defmodule Vinylize.Repo.Migrations.RenameCategoryToCategoryIdInProductTable do
  use Ecto.Migration

  def change do
    alter table(:products) do
      remove :category
    end
  end
end
