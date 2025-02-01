defmodule SyrupyApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SyrupyApi.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password_hash: "some password_hash",
        email: "some email"
      })
      |> SyrupyApi.Accounts.create_user()

    user
  end
end
