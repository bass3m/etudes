defmodule Geom do
  @moduledoc """
  Calculate Areas
  """
  @doc """
  Area of a rectangle, with default values of 1
  """
  def area(h \\ 1,w \\ 1) do
    h * w
  end
end
