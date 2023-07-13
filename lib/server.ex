defmodule Server do
  use Application

  def start(_type, _args) do
    IO.puts("Starting Primy server")
    IO.puts(node())
    with :ok <- setupDatabase() do
      pid = spawn(fn -> handlePrimeRequests() end)
      Process.register(pid, :primy_server)
      {:ok, pid}
    end
  end

  def handlePrimeRequests() do
    IO.puts("listnening")
    receive do
      {:give_me_prime, pid} ->
        # send next prime to worker
        IO.puts("give me a prime")
        send(pid, {:new_prime, 777})
      {:store_prime, prime} ->
        storePrime(prime)
      msg ->
        IO.puts(["Unknown message", msg])
    end
    handlePrimeRequests()
  end

  def setupDatabase() do
    IO.puts("Setting up database")
    :ok
  end



  def storePrime(prime) do
    ## storing logic here
    IO.puts(["Saving prime number ", prime])
  end

end
