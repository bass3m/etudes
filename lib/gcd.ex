defmodule Gcd do
  @moduledoc """
  Calculate the GCD using Djikstra's method
  iex(2)> Dijkstra.gcd(2, 8)
  2
  iex(3)> Dijkstra.gcd(14, 21)
  7
  iex(4)> Dijkstra.gcd(125, 46)
  1
  iex(5)> Dijkstra.gcd(120, 36)
  12
  """
  def gcd(m,n) when m == n, do: m
  def gcd(m,n) when m > n, do: gcd(n,m-n)
  def gcd(m,n) when n > m, do: gcd(m,n-m)
end
