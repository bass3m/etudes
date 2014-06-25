defmodule AtomicMaker do
  @moduledoc """
  Macros that return the atomic weight of an element
  """
  defmacro generate_atomic_weights(weights) do
    for {atom, weight} <- weights do
      quote do
          def unquote(atom), do: unquote(weight)
      end
    end
  end
end
