defmodule Cards do
  @ranks ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]

  def make_deck() do
    suites = ["Hearts","Diamonds","Clubs","Spades"]
    for r <- @ranks, s <- suites, do: {r,s}
  end

  defp card_index({rank,_} = card) do
    @ranks
    |> Enum.with_index
    |> Enum.find(fn({r,index})-> r == rank end)
    |> elem(1)
  end

  def card_compare(card1,card2) do
    card_index(card1) > card_index(card2)
  end

  @doc """
  shuffling of a list (of cards)
  """
  def shuffle(list) do
    shuffle(list,[])
  end
  def shuffle([],acc), do: acc
  def shuffle(list,acc) do
    {head,[x | xs]} = Enum.split(list,:random.uniform(length(list)) - 1)
    shuffle(head ++ xs,[x | acc])
  end
end
