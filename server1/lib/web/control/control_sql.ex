#defmodule Server1.Control do

#	alias Server1.Frutas
	
	#def muestra_todo(conn, _params) do
#		users = Repo.all(Frutas)#despliega toda la infor de la base de datos
#	end
#
#	def muestra(conn, %{"id" => id}) do
#		nombre = Repo.get!(Frutas, id)
#		render(conn, "show.html", user: user)
#	end
#
#	def nuevo(conn, _params) do
#		changeset = Frutas.changeset(%Frutas{})
#		render(conn, "new.html", changeset: changeset)
#	end
#
#	def create(conn, %{"user" => user_params}) do
#		changeset = Frutas.changeset(%Frutas{}, user_params)
#		Repo.insert(changeset)
#	end
#
#	def editar(conn, %{"id" => id}) do
#		user = Repo.get!(user)
#		changeset = User.changeset(user)
#		render(conn, "edit.html", user: user, changeset: changeset)
#	end
#
#	def update(conn, %{"id" => id, "user" => user_params})do
#		user = Repo.get(User, id)
#		changeset = Frutas.changeset(user, user_params)
#		Repo.uddate(changeset)
#	end
#
#	def borrar(conn, %{"id" => id})do
#		user = Repo.get!(User,id)
#		Repo.delete!(user)
#
#		conn
#		|> put_flash(:danger, "User deleted succesfully")
#		|> redirect(to: user_path(conn, :index))
#	end
#end