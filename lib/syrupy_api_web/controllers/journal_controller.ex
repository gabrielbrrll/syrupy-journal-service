defmodule SyrupyApiWeb.JournalController do
  use SyrupyApiWeb, :controller

  alias SyrupyApi.Journals
  alias SyrupyApi.Journals.Journal

  action_fallback SyrupyApiWeb.FallbackController

  def index(conn, _params) do
    journals = Journals.list_journals()
    render(conn, "index.json", journals: journals)
  end

  def create(conn, %{"journal" => journal_params}) do
    with {:ok, %Journal{} = journal} <- Journals.create_journal(journal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.journal_path(conn, :show, journal))
      |> render("show.json", journal: journal)
    end
  end

  def show(conn, %{"id" => id}) do
    journal = Journals.get_journal!(id)
    render(conn, "show.json", journal: journal)
  end

  def update(conn, %{"id" => id, "journal" => journal_params}) do
    journal = Journals.get_journal!(id)

    with {:ok, %Journal{} = journal} <- Journals.update_journal(journal, journal_params) do
      render(conn, "show.json", journal: journal)
    end
  end

  def delete(conn, %{"id" => id}) do
    journal = Journals.get_journal!(id)

    with {:ok, %Journal{}} <- Journals.delete_journal(journal) do
      send_resp(conn, :no_content, "")
    end
  end
end
