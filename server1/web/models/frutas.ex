defmodule Server1.Fruits do
  use Server1.Web, :model

  schema "fruit" do
    field :name, :string
    field :details, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :details])
    |> validate_required([:name, :details])
    |> unique_constraint(:name)
  end
end
