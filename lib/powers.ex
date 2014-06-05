defmodule Powers do
  import Kernel, except:  [raise: 2]

  def raise(_x,0), do: 1
  def raise(x,1), do: x
  def raise(x,n) when n < 0 do
    1/raise(x,-n)
  end
  def raise(x,n) do
    x * raise(x,n-1)
  end
end
