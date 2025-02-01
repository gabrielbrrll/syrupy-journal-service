defmodule SyrupyApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  A basic changeset for user creation or update.
  """
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> hash_password()
  end

  defp hash_password(changeset) do
    if pw = get_change(changeset, :password) do
      put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pw))
    else
      changeset
    end
  end
end
