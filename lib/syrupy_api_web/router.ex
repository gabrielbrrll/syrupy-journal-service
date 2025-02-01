defmodule SyrupyApiWeb.Router do
  use SyrupyApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    # Example using Guardian plugs. Replace with your own auth plugs if needed.
    plug Guardian.Plug.Pipeline,
      module: SyrupyApi.Guardian,
      error_handler: SyrupyApiWeb.AuthErrorHandler
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  scope "/api", SyrupyApiWeb do
    pipe_through :api
    # You can define public API routes here.
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: SyrupyApiWeb.Telemetry
    end

    # Public user registration and login routes:
    scope "/api", SyrupyApiWeb do
      pipe_through :api

      post "/users/register", UserController, :create
      post "/users/login", UserController, :login
    end

    # Protected journal routes:
    scope "/api", SyrupyApiWeb do
      pipe_through [:api, :auth]
      resources "/journals", JournalController, except: [:new, :edit]
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
