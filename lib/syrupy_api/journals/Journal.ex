defmodule SyrupyApi.Journals.Journal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "journals" do
    field :title, :string
    field :content, :string
    field :mood, :string
    belongs_to :user, SyrupyApi.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(journal, attrs) do
    journal
    |> cast(attrs, [:title, :content, :mood, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
