defmodule EctoUnionExample.Notes.Note do
  use Ecto.Schema
  alias EctoUnionExample.Notes
  alias EctoUnionExample.Notes.Union, as: NotesUnion
  import Ecto.Changeset

  @tag_atoms Map.keys(Notes.tags())

  @type t :: %__MODULE__{
          data: NotesUnion.t(),
          tag: :personal | :work
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "notes" do
    field(:data, NotesUnion, read_after_writes: true)
    field(:tag, Ecto.Enum, values: @tag_atoms)
    field(:text, :string)
  end

  @doc """
  Create a changeset for a Note that has a permissible tag.

  Adds the `tag` to the `data` for the underlying struct that is part of the NotesUnion.
  """
  def create_changeset(%{tag: tag, data: %{}} = params) when tag in @tag_atoms do
    params = Map.update!(params, :data, &Map.put(&1, :tag, tag))

    %__MODULE__{id: Ecto.UUID.generate()}
    |> cast(params, __schema__(:fields))
    |> validate_required(__schema__(:fields))
  end
end
