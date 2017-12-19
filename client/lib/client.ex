defmodule Client do
  @moduledoc false
  require Logger
  alias Phoenix.Channels.GenSocketClient
  @behaviour GenSocketClient
  @server_id "server:1"  # <-- the name of your channel :p 

  #I recommend you to run this app with the next comand:
  #{:ok, pid}=Client.start_link()
  #That will add info at "pid" which we will use latter on for the "push" function

  def start_link() do
    GenSocketClient.start_link(__MODULE__, 
      GenSocketClient.Transport.WebSocketClient,
          "ws://localhost:4000/socket/websocket")
          #/adress_if there's any/socket/websocket")
          #"ws://localhost:4000/example/.../socket/websocket")
          #this is asigned to "URL" variable at "init"
  end


############## PROTOCOLS OF CONNECTION AND COMMUNICATION
  def init(url) do
    Logger.info("Iniciating the connection protocol")
    {:connect, url, [] , [:state]} #<- That MUST stay that way, 
   #The "Aircloak" is specting the information just like it is displayed there,
   #maybe we can change "url" name since it is just a variable

    #If init returns the tuple from above the socket process will try
    #to connecto to the server. The connection is established in
    #a separate process which we call the transport process. 
    #Said process is the immediate child of the socket process
    #As a consequence, all communication takes place concurrently
    #to the socket process. If you handle messages in the socket
    #you may need to keep track of whether you're connected or not.

    #The establishing of connection is done asynchronously.
  end

  def handle_connected(transport, state) do
    # this callback is invoked after the connection is established
    Logger.info("Joined to server")
    GenSocketClient.join(transport, @server_id)
    {:ok, state}
  end

    def handle_disconnected(reason, state) do
    Logger.error("Se ha desconectado el servidor: #{inspect reason}")
       #GenSocketClient.join(transport, "room:lobby")
                           #(transport, "channel:name")
    {:ok, state}
  end

  def handle_joined(your_channel, _payload, _transport, state) do
    Logger.info("Successul join!")
    {:ok, state}
 end

  def handle_message(your_channel, ref, payload, transport, state) do
      Logger.info("Some info...")
      #This will handle the messages that we get from our server
      Logger.info(" #{inspect payload}")
      #It will display the payload that the channel just gave to us :) 
      {:ok, state}
  end

 ##########################################SENDING INFORMATION

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


  def push(client_pid, your_channel, event, payload \\ %{}) do
    GenSocketClient.call(client_pid, {:push, your_channel, event, payload})
    Logger.info("A message was sent")
  end

  def handle_reply(_, _, payload, _transport, state) do
    Logger.info("Receiving an answer from the server: ")
     Logger.info("#{inspect(payload)}")
    {:ok, state}
  end

##############################################################################


  def handle_call({:push, your_channel, event, payload}, _from, transport, client) do
    push_result = GenSocketClient.push(transport, your_channel, event, payload)
    {:reply, push_result, client}
  end
  ################################

  #Handler de conexión fallida
  def handle_join_error(canal, payload, _transport, state) do
   Logger.error("Error on channel joining: #{canal}: #{inspect payload}")
    Logger.info("Maybe it is not available or the written name is wrong")
    {:ok, state}
  end

    def handle_reply(_topic, _contador, payload, _transport, client) do
    Logger.info("Receiving an unhandled answer")
    Logger.info("#{inspect(payload)}")
    {:ok, client}
  end
end