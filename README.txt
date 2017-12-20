Manuel Eduardo Martínez Vera -- LoneStar  (zatch15@hotmail.com)  -- @slack/phx;elixir;nerves||general "LoneStar"
Let me know any doubt or issue :D Regards! (English && Spanish)

https://github.com/Aircloak/phoenix_gen_socket_client <--- Original AirCloak code :)

WHAT DOES THIS DOES!?

######################################################
This is a protocol of communication between a Phoenix Server and an Elixir Client

It has no GUI, all the interaction is being taken at the console.

You have a set of instructions at the "Server" channel, the client sends petitions 
at the different instructions that are inside the server. Petitions like "New", "Show", etc.

So the server takes data to a data base, it could be a insertion, edition, addition or erasing.

"Why is it the big deal?" Becuase it interacts using the "wi-fi" you could implement these instructions on Nerves
or on a PC console project :) All thanks to the Aircloak connection protocol.

######################################################

How it works?

```
@ server folder you run:
mix deps.get <-- updates your phx deps
&&
mix ecto.create <-- creates databasse
&&
mix ecto.migrate <-- creates table on data base

Then:
mix phx.server  <-- run the server! :3
```

``` 
@client folder:
mix deps.get
&&
iex -S mix <- For usage
```

start the client with:

{:ok, pid}=Client.start_link()

This is an open source code! Go ahead and use it!

BUT!!! Im not responsible for the misuse of anykind,
Also, If your computer blows up in a bunch of small pieces is not my fault :)

Thank a lot to Mr. Saša Juric (sasa1977 @slack). Without his help this could not be possible

Regards!! :D

COPY/PASTE cus im a lazy rascal

 #The function "Push" will take your query directly to the server
 #You need to fill it out like:

 # Client.push(pid, "name of your channel", "event", %{info1: "something1", info2: "something2"})

 #Since our server is programmed for filling a "fruits baskets list" it is specting something like this:

# Client.push(pid, "server:1", "<an event>", %{name: "something1", detail: "something2"})

# You can select some events to happen:

#"new" : it spects a name and a detail of a fruit, the name cannot be repeated so if by any chance
#         you type in a name of a fruit that already exists on a data base it will return an error
# Client.push(pid, "server:1", "new", %{name: "apple", detail: "tasty fruit"})


#"show_all" : It will display all the content inside the data base
# Client.push(pid, "server:1", "show_all", %{})

#"show" : it will display a selected "id" from our data base
# Client.push(pid, "server:1", "show", %{id: # of id})
#If it cannot get back a correct value it will return a warning telling you that something is wrong

#"edit" : It will let you do an edition on the details of a fruit that you request by it's id
# Client.push(pid, "server:1", "edit", %{id: # of id, detail: "the info you want to edit"})
#It will do the requested edition and if by anychance 

#"delete" : It will delete the information of a given ID inside the data base.
# Client.push(pid, "server:1", "delete", %{id: # of id})
#If it cannot delete it properly it will return a warning
