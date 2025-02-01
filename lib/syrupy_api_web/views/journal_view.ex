defmodule SyrupyApiWeb.JournalView do
  use SyrupyApiWeb, :view
  alias SyrupyApiWeb.JournalView

  def render("index.json", %{journals: journals}) do
    %{data: render_many(journals, JournalView, "journal.json")}
  end

  def render("show.json", %{journal: journal}) do
    %{data: render_one(journal, JournalView, "journal.json")}
  end

  def render("journal.json", %{journal: journal}) do
    %{
      id: journal.id,
      title: journal.title,
      content: journal.content,
      mood: journal.mood,
      user_id: journal.user_id,
      inserted_at: journal.inserted_at,
      updated_at: journal.updated_at
    }
  end
end
