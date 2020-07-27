defmodule DndMatchmaker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :password, :string
      add :password_salt, :string

      timestamps()
    end

  end
end
