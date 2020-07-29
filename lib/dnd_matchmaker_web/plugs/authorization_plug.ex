defmodule DndMatchmakerWeb.Plugs.AuthorizationPlug do\
  @behaviour Plug

  import Plug.Conn

  @authorization_header "authorization"

  def init(options) do
    options
  end

  def call(conn, _options) do
    case conn |> get_bearer_token() do
      {:ok, bearer_token} ->
        case DndMatchmakerWeb.JWT.verify_and_validate(bearer_token) do
          {:ok, %{"sub" => user_id}} -> put_private(conn, :user_id, user_id)
          {:error, msg} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(401, Jason.encode!(%{error: %{message: msg}}))
            |> halt()
        end
      {:error, msg} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{error: %{message: msg}}))
        |> halt()
    end
  end

  defp get_bearer_token(conn) do
    case conn |> get_req_header(@authorization_header) do
      ["Bearer " <> bearer_token] -> {:ok, bearer_token}
      ["Basic " <> _]             -> {:error, :basic_auth_not_supported}
      _                           -> {:error, :bearer_token_not_found}
    end
  end
end
