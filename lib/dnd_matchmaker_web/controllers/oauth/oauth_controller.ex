defmodule DndMatchmakerWeb.OAuthController do
  use DndMatchmakerWeb, :controller

  action_fallback DndMatchmakerWeb.FallbackController

  def authorize(conn, params) do
    with {:ok, token} <- params |> get_token do
      conn |> render(%{token: token})
    end
  end

  defp get_token(%{"grant_type" => "password", "username" => username, "password" => password}) do
    with user <- DndMatchmaker.Accounts.get_user_by_username!(username) do
      if Bcrypt.verify_pass(password, user.password) do
        info = %{"sub" => user.id, "username" => user.username}
        token = DndMatchmakerWeb.JWT.generate_and_sign!(info)
        {:ok, token}
      else
        {:error, :unauthorized, :no_username_or_pass_match}
      end
    end
  end

  defp get_token(_params) do
    {:error, :bad_request, :invalid_grant_type}
  end
end
