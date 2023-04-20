defmodule EctoUnionExample.Notes.Union do
  @moduledoc """
  Custom `Ecto.Type` treat the structure of a `Note` `data` property as a sum type.

  Each Note carries a `tag` that maps to a module defined under the `StructuredData` namespace.
  Each module must define a `new/1` function (TODO: behaviour) that returns `{:ok, struct} |
  {:error, keyword()}`. Such structs must have a `tag` key that holds the same value of the
  original `tag`.

  """

  use Ecto.Type
  require Logger
  alias EctoUnionExample.Notes
  alias EctoUnionExample.Notes.{Personal, Work}

  @tags Notes.tags()
  @tag_atoms Map.keys(@tags)
  @tag_strings Enum.map(@tag_atoms, &Atom.to_string/1)

  @type t :: Personal.t() | Work.t()

  @impl Ecto.Type
  def type, do: :map

  # Dictates how the type should be treated inside embeds
  @impl Ecto.Type
  def embed_as(_), do: :dump

  @impl Ecto.Type
  def cast(%{tag: tag} = map) when tag in @tag_atoms do
    @tags
    |> Map.fetch!(tag)
    |> then(& &1.new(map))
  end

  def cast(%{"tag" => tag} = map) when tag in @tag_strings do
    @tags
    |> Map.fetch!(String.to_existing_atom(tag))
    |> then(& &1.new(map))
  end

  def cast(_), do: :error

  @impl Ecto.Type
  def dump(%{tag: tag} = map) when tag in @tag_atoms do
    updated = Map.update!(map, :tag, &Atom.to_string/1)

    {:ok, updated}
  end

  def dump(_), do: :error

  @impl Ecto.Type
  def load(%{"tag" => tag} = map) when tag in @tag_strings do
    @tags
    |> Map.fetch!(String.to_existing_atom(tag))
    |> then(& &1.new(map))
  end

  def load(%{"tag" => tag} = map) do
    Logger.warn("StructuredData: unknown tag `#{tag}` when loading a note")

    {:ok, map}
  end
end
