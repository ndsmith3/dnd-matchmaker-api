defmodule DndMatchmaker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :password_salt, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    with salt <- Bcrypt.gen_salt() do
      user
      |> cast(attrs, [:email, :username, :password])
      |> put_change(:password_salt, salt)
      |> validate_required([:email, :username, :password, :password_salt])
      |> update_change(:password, &(Bcrypt.Base.hash_password(&1, salt)))
    end
  end
end
