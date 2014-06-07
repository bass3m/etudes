defmodule Powers do
  import Kernel, except:  [raise: 2, raise: 3]

  def raise(_x,0), do: 1
  def raise(x,1), do: x
  def raise(x,n) when n < 0 do
    1/raise(x,-n)
  end
  def raise(x,n) do
    raise(x,n,1)
  end

  def raise(_x,0,acc), do: acc
  def raise(x,n,acc) do
    raise(x,n-1,acc*x)
  end

  # Helper function; given estimate for x^n,
  # recursively calculates next estimated root as
  # estimate - (estimate^n - x) / (n * estimate^(n-1))
  # until the next estimate is within a limit of previous estimate.
  @doc """
  Calculate the nth root of x using the Newton-Raphson method.
  """
  def nth_root(x,n), do: nth_root(x,n,x/2.0)
  defp nth_root(x,n,a) do
    IO.puts("Current guess is #{a}")
    f = raise(a,n) - x
    f_prime = n * raise(a,n - 1)
    next = a - f/f_prime
    change = abs(next - a)
    if change < 1.0e-8 do
      a
    else
      nth_root(x,n,next)
    end
  end
end
