defmodule Dates do
  @moduledoc """
  date_parse/1 take a date string in yyyy-mm-dd
  format, returns a list of integers in the form
  [yyyy, mm, dd]
  """
  def date_parts(date_string) do
    date_string
    |> String.split("-")
    |> Enum.map(&(binary_to_integer/1))
  end
  @doc """
  Converts a date string to the number of day in the year
  """
  def julian(date_string) do
    days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]
    [year,month,day] = date_parts(date_string)
    # why the -2 ? : we don't count the last day in the current month
    # since it's covered by the day.
    # we also index the array from 0 while the months start from 1
    0..month-2
    |> Enum.into([])
    |> List.foldl(day,fn (d,acc) -> acc + Enum.at(days_in_month,d) end)
    |> add_leap_day(year)
  end

  defp add_leap_day(total,year) do
    if is_leap_year(year) do
      total + 1
    else
      total
    end
  end

  defp is_leap_year(year) do
    (rem(year,4) == 0 and rem(year,100) != 0)
    or (rem(year, 400) == 0)
  end
end
