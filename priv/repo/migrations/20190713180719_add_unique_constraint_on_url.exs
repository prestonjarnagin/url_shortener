defmodule Url.Repo.Migrations.AddUniqueConstraintOnUrl do
  use Ecto.Migration

  def change do
    create unique_index(:urls, [:url])
  end
end
