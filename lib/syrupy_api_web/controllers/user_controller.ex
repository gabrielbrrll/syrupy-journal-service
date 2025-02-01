defmodule SyrupyApiWeb.UserController do
  use SyrupyApiWeb, :controller

  alias SyrupyApi.Accounts
  alias SyrupyApi.Accounts.User

  # Registers a new user
  # Expects params in the format: {"user" => %{"email" => ..., "password" => ...}}
  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, %User{} = user} ->
        conn
        |> put_status(:created)
        |> json(%{
          "id" => user.id,
          "email" => user.email,
          "message" => "User created successfully"
        })

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  # Logs in an existing user
  # Expects params in the format: {"user" => %{"email" => ..., "password" => ...}}
  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        # Generate a JWT token using Guardian
        {:ok, token, _claims} = Guardian.encode_and_sign(user, %{})
        conn
        |> json(%{
          "token" => token,
          "user" => %{
            "id" => user.id,
            "email" => user.email
          }
        })

      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid email or password"})
    end
  end

  # Helper function to translate changeset errors
  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
