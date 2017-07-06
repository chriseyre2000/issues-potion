defmodule Issues.JiraIssues do
  @user_agent "Elixir Issues"
  @github_url Application.get_env(:issues, :github_url)
  
  def fetch(user, password) do
    issues_url(user, password) 
	|> HTTPotion.get([basic_auth: {"foo", "bar"}])
	|> handle_response
  end
  
  def issues_url(user, password) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end
  
  def handle_response({%{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end
  
  def handle_response({%{status_code: _, body: body}}) do
    {:error, Poison.Parser.parse!(body)}
  end

end