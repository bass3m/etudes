defmodule Duration do
  @moduledoc """
  Tuples represent a duration of time in minutes and seconds
  add takes two tuples as arguments and returns the total duration
  iex(1)> require Duration
  nil
  iex(2)> Duration.add({2,15},{3,12})
  {5,27}
  iex(3)> Duration.add({2,45},{3,22})
  {6,7}
  """
  defmacro add({m1,s1},{m2,s2}) do
    quote do
      total_secs = unquote(s1) + unquote(s2)
      if total_secs > 59 do
        {unquote(m1) + unquote(m2) + 1, rem(total_secs,60)}
      else
        {unquote(m1) + unquote(m2),total_secs}
      end
    end
  end

  @doc """
  iex(1)> require Duration
  nil
  iex(2)> Duration.+({1, 27}, {2, 44})
  {4,11}
  iex(3)> Kernel.+(7, 5)
  12
  """
  defmacro {m1,s1} + {m2,s2} do
    quote do
      total_secs = unquote(s1) + unquote(s2)
      if total_secs > 59 do
        {unquote(m1) + unquote(m2) + 1, rem(total_secs,60)}
      else
        {unquote(m1) + unquote(m2),total_secs}
      end
    end
  end

  defmacro a + b do
    quote do
      unquote(a) + unquote(b)
    end
  end
end
