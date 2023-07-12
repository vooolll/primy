defmodule Server do

  def start() do
    IO.puts("Starting Primy server")
    receive do
      {:give_me_prime} ->
        # code
      {:store_prime, prime} ->

    end

     ## storing logic here
  end

  def setupDatabase() do
    IO.puts("Setting up database")
  end


  def storePrime(prime) do
    IO.puts("Saving prime number")
  end

end
