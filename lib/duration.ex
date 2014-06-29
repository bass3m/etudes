defmodule Duration do
  @moduledoc """
  Tuples represent a duration of time in minutes and seconds
  add takes two tuples as arguments and returns the total duration
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
end
