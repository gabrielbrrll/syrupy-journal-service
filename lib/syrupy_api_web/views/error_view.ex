defmodule SyrupyApiWeb.ErrorView do
  use SyrupyApiWeb, :view

  def render("404.json", _assigns) do
    %{error: "Resource not found"}
  end

  def render("500.json", _assigns) do
    %{error: "Internal server error"}
  end

  def template_not_found(_template, assigns) do
    render("500.json", assigns)
  end
end
