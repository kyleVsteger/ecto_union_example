defmodule EctoUnionExample.Repo.Migrations.Initial do
  use Ecto.Migration

  def change do
    create table(:notes, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add :data, :map
      add :tag, :string
      add :text, :string
    end
  end
end
