defmodule Server do
  use Application

  def start(_type, _args) do
    IO.puts("Starting Primy server")
    IO.puts(node())
    with :ok <- setupDatabase() do
      pid = spawn(fn -> handlePrimeRequests(1000000000) end)
      Process.register(pid, :primy_server)
      {:ok, pid}
    end
  end

  def handlePrimeRequests(number) do
    receive do
      {:give_me_number, pid} ->
        # send next prime to worker
        send(pid, {:new_number, number})
      {:store_prime, prime} ->
        storePrime(prime)
    end
    handlePrimeRequests(number + 1)
  end

  def setupDatabase() do
    IO.puts("Setting up database")
    :ok
  end



  def storePrime(prime) do
    ## storing logic here
    IO.puts(inspect(["Saving prime number ", prime]))
  end

end
