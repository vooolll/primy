defmodule PrimyTest do
  use ExUnit.Case
  doctest Primy

  test "fermat" do
    IO.puts Fermat.test(65421378512736521765, 100)
  end

end
