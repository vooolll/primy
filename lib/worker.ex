defmodule Worker do

  def listenTask() do
    # understand why it is not working with mix
    receive do
      {:new_number, number} ->
        #10 trys to test - completley arbitrary number
        case Fermat.test(number, 10) do
          :ok ->
            sendServer({:store_prime, number})
          :no ->
            sendServer({:give_me_number, self()})
          end
    end
    listenTask()
  end

  def start() do
    IO.puts("Starting worker")
    IO.puts(node())

    for n <- 1..100 do
      IO.puts(inspect(["Spawning process", n]))
      spawn(fn -> listenTask() end)
    end


  end


  def sendServer(message) do
    send({:primy_server, :"primy_server@administrators-MacBook-Pro-2"}, message)
  end

end
