defmodule Cards do
  def make_deck() do
    ranks = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    suites = ["Hearts","Diamonds","Clubs","Spades"]
    for r <- ranks, s <- suites, do: {r,s}
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
