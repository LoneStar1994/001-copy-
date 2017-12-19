defmodule Server1.Channel do
  use Phoenix.Channel
  alias Server1.Fruits
  alias Server1.Repo
  require Logger

  def join("server:1", _payload, socket) do
  	{:ok, socket}
  end

  def join(_,_,_) do 
  {:error, %{reason: "Wrong Connection"}}
  end

  def handle_in("show_all", _payload, socket) do
    info = Repo.all(Fruits)

    #Since we got an answer with "__meta__:" and "__struct__:" we need to
    #strip down that info, otherwise the "transport" will have some serious issues
    #so we do a tricky "ENUM.MAP" in order to delete the info

    #SPECIAL THNX TO: (Guy who's name i cannot remember but was very kind at slack)
    # Many thanks from LoneStar :D 

            |> Enum.map(fn(info) -> 
                Map.drop(info, [:__meta__, :__struct__]) end)
  	{:reply, {:ok, %{msg: info}},socket}
  end

  def handle_in("show", payload, socket) do
    info=Repo.get(Fruits, payload["id"])
    if is_nil(info) do
    answer="Got no info back, empty ID"
    else  
    answer=Map.delete(info, :__meta__)

    #Again a tricky solution but gets thing done, so its okay,
    #This strips down all the ":__meta__" from our map,
    #Otherwise it returns a horrible error!

    end 
    {:reply, {:ok, %{msg: answer}}, socket}
  end

  def handle_in("new", payload, socket) do
    if is_nil(payload["name"]) do
    answer="name field cannot be empty"
    else 
    Repo.insert(%Frutas{name: payload["name"], details: payload["details"]})
    answer="Successfully created"
    end
    {:reply, {:ok, %{msg: answer}}, socket}
  end

  def handle_in("edit", payload, socket) do
    fruit = Repo.get(Fruits, payload["id"])
    if is_nil(fruit) do
    answer="No se pudo acompletar operacion, revise peticion"
    else  
    changeset = Frutas.changeset(fruit, %{details: payload["details"]})
    Repo.update(changeset)    
    answer="successfully created"
    end 
    {:reply, {:ok, %{msg: answer}},socket}
  end

  def handle_in("delete", payload, socket) do
    fruit = Repo.get(Fruits, payload["id"])
    if is_nil(fruit) do
    answer="Something went wrong, check your petition, maybe wrong ID?"
    else  
    answer=Fruits.changeset(fruit, %{details: payload["details"]})
    Repo.update(changeset)    
    answer="An element was deleted"
    end 
    {:reply, {:ok, %{msg: answer}},socket}
  end
end
