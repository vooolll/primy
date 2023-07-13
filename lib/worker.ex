defmodule Worker do

  def listenTask() do
    receive do
      {:new_prime, number} ->
        IO.puts(["New prime recieved", number])
    end

  end
  def start() do
    IO.puts("Starting worker")
    IO.puts(node())

    pid = spawn(fn -> listenTask() end)
    # understand why it is not working with mix
    send({:primy_server, :"primy_server@administrators-MacBook-Pro-2"}, {:give_me_prime, pid})
  end

end
