defmodule Fermat do
    @moduledoc """
  Fermat algorithm for providing prime numbers with very high accuracy.
  """

  def mpow(n, 1, _) do
    n
  end

  def mpow(n, k, m) do
    mpow(rem(k,2), n, k, m)
  end

  def mpow(0, n, k, m) do
    x = mpow(n, div(k,2), m)
    rem(x * x,  m)
  end

  def mpow(_, n, k, m) do
    x = mpow(n, k - 1, m)
    rem(x*n, m)
  end

  def fermat(p) do
    r = :rand.uniform(p-1)
    t = mpow(r, p-1,p)
    if (t == 1) do
      :ok
    else
      :no
    end
  end

  def test(_, 0) do
    :ok
  end


  def test(p, n) do
    case fermat(p) do
       :ok ->
        test(p, n - 1)
       :no ->
        :no
    end
  end


end
