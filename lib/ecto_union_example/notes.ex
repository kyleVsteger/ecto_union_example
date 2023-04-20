defmodule EctoUnionExample.Notes do
  alias EctoUnionExample.Notes.{Personal, Work}

  @tags %{
    personal: Personal,
    work: Work
  }

  @doc """
  The list of tags permissible on a `Note`.
  """
  @spec tags() :: map()
  def tags, do: @tags
end
