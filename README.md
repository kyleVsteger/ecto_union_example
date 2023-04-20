# EctoUnionExample

- Start up a standard postgres container
- Run `mix ecto.setup`
- Start a server `iex -S mix phx.server`
- Insert some data:

```elixir
alias EctoUnionExample.Notes.Note
alias EctoUnionExample.Notes.{Personal, Work}

work_note_params = %{
    tag: :personal,
    text: "life is great!",
    data: %{mood: "lovely", category: "random"}
  }

{:ok, %Note{data: %Work{}}} =
  work_note_params
  |> Note.create_changeset()
  |> EctoUnionExample.Repo.insert()

personal_note_params = %{
    tag: :personal,
    text: "life is great!",
    data: %{mood: "lovely", category: "random"}
  }

{:ok, %Note{data: %Personal{}}} =
  personal_note_params
  |> Note.create_changeset()
  |> EctoUnionExample.Repo.insert()


EctoUnionExample.Repo.all(Note)
```
