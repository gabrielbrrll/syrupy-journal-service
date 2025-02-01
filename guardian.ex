defmodule SyrupyApi.Guardian do
  alias Guardian, as: GuardianLib
  use GuardianLib, otp_app: :syrupy_api
  alias SyrupyApi.Accounts

  def subject_for_token(user, _claims),
    do: {:ok, to_string(user.id)}

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  # Custom helper that delegates to the built-in multi-arity function.
  def encode_and_sign(resource) do
    GuardianLib.encode_and_sign(__MODULE__, resource, %{})
  end
end
