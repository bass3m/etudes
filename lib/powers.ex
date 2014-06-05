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
end
