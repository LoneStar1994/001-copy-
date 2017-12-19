defmodule Server1.FrutasTest do
  use Server1.ModelCase

  alias Server1.Frutas

  @valid_attrs %{detalles: "some content", nombre: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Frutas.changeset(%Frutas{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Frutas.changeset(%Frutas{}, @invalid_attrs)
    refute changeset.valid?
  end
end
