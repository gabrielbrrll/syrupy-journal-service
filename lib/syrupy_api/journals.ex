defmodule SyrupyApi.Journals do
  @moduledoc """
  The Journals context.
  """

  import Ecto.Query, warn: false
  alias SyrupyApi.Repo
  alias SyrupyApi.Journals.Journal

  def list_journals do
    Repo.all(Journal)
  end

  def get_journal!(id), do: Repo.get!(Journal, id)

  def create_journal(attrs \\ %{}) do
    %Journal{}
    |> Journal.changeset(attrs)
    |> Repo.insert()
  end

  def update_journal(%Journal{} = journal, attrs) do
    journal
    |> Journal.changeset(attrs)
    |> Repo.update()
  end

  def delete_journal(%Journal{} = journal) do
    Repo.delete(journal)
  end

  def change_journal(%Journal{} = journal, attrs \\ %{}) do
    Journal.changeset(journal, attrs)
  end
end
