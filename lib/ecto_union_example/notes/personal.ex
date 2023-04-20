defmodule EctoUnionExample.Notes.Personal do
  @moduledoc """
  A permutation of `EctoUnionExample.Notes.Union` representing a "personal" `Note`.
  """

  import Ecto.Changeset
  use Ecto.Schema

  @type t :: %__MODULE__{
          tag: :personal,
          mood: String.t(),
          category: String.t()
        }

  @derive Jason.Encoder
  @primary_key false
  embedded_schema do
    # A little hacky, but ensures it lines up in `EctoUnionExample.Notes.Union`
    field(:tag, Ecto.Enum, values: [:personal], default: :personal)
    field(:mood, :string)
    field(:category, :string)
  end

  # Called by `EctoUnionExample.Notes.Union` when reading from DB
  def new(params) do
    fields = __MODULE__.__schema__(:fields)

    %__MODULE__{}
    |> cast(params, fields)
    |> validate_required(fields)
    |> apply_action(:update)
  end
end
