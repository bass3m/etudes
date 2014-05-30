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
  def area(:rectangle,h,w) do
    h * w
  end
  def area(:triangle,b,h) do
    (b * h)/2
  end
  def area(:ellipse,a,b) do
    :math.pi() * a * b
  end
end
