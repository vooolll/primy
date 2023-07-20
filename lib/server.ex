defmodule Server do
  use Application

  alias :mnesia, as: Mnesia

  def start(_type, _args) do
    IO.puts("Starting Primy server")
    IO.puts(node())
    with :database_up <- setupDatabase() do
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
      {:found_prime, prime, id} ->
        storePrime(id, prime)
        readPrime(id)
        other -> IO.puts(inspect(other))
    end
    handlePrimeRequests(number + 1)
  end

  def setupDatabase() do
    IO.puts("Setting up database")
    case Mnesia.create_table(Prime, [attributes: [:wroker_id, :prime]]) do
      {:atomic, :ok} ->
        Mnesia.add_table_index(Prime, :prime)
        :database_up
      {:aborted, {:already_exists, Prime}} ->
        :database_up
        other ->
          {:error, other}
    end
  end



  def storePrime(worker_id, prime) do
    Mnesia.dirty_write({Prime, worker_id, prime})
  end



  def readPrime(worker_id) do
    IO.puts(inspect(Mnesia.dirty_read(Prime, worker_id)))
    :ok
  end

end
