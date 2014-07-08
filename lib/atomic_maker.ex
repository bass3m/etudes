defmodule AtomicMaker do
  @moduledoc """
  Macros that return the atomic weight of an element
  iex(1)> c("atomic_maker.ex")
  [AtomicMaker]
  iex(2)> c("atomic.ex")
  [Atomic]
  iex(3)> import Atomic
  nil
  iex(4)> water = h * 2 + o
  18.015
  iex(5)> sulfuric_acid = h * 2 + s + o * 4
  98.072
  iex(6)> salt = na + cl
  58.44
  """
  defmacro generate_atomic_weights(weights) do
    for {atom, weight} <- weights do
      quote do
          def unquote(atom), do: unquote(weight)
      end
    end
  end
end
