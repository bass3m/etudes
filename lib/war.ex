defmodule War do
  @moduledoc """
  A game of war between processes with a dealer to mediate
  Defaults to 2 players
  """
  import Cards

  defstruct game_state: :init,
            players: [],
            card_pile: [],
            waiting_on: 2

  @doc """
  get a card deck, and shuffle it
  start num players processes and
  send players their cards
  """
  def start_game(num_players \\ 2,deck_size \\ 52) do
    dealer = self()
    player_decks = Cards.make_deck()
                    |> Cards.shuffle
                    |> Enum.slice(0..deck_size-1)
                    |> Enum.split(Float.floor(deck_size/num_players))
    players = Enum.map(0..num_players-1,
                       fn(n) -> %{pid: spawn(__MODULE__,
                                             :player_loop,
                                             [dealer,elem(player_decks,n)]),
                                  cards: []} end)
    dealer_loop(%War{players: players, waiting_on: num_players})
  end

  # when we're at war we take 3 cards otherwise just 1 card
  defp cards_to_give(state) when state == :war, do: 3
  defp cards_to_give(_state), do: 1

  def dealer_loop(%War{players: [%{pid: pid1,
                                   cards: [h1 | _] = cards1} = p1,
                                 %{pid: pid2,
                                   cards: [h2 | _] = cards2} = p2] = players,
                       card_pile: pile,
                       game_state: state} = war) do
    cond do
      cards_equal?(h1,h2) ->
        IO.puts("Cards equal #{inspect h1} and #{inspect h2}")
        dealer_loop(%War{card_pile: Enum.concat([pile,cards1,cards2]),
                         game_state: :war,
                         players: [%{pid: pid1, cards: []},
                                   %{pid: pid2, cards: []}]})
      is_higher_rank?(h1,h2) ->
        IO.puts("Player 1 wins #{inspect h1} of #{inspect h2}")
        send(pid1, {:take_cards, Enum.concat([pile,cards1,cards2])})
        dealer_loop(%War{game_state: :init,
                         players: [%{pid: pid1, cards: []},
                                   %{pid: pid2, cards: []}]})
      true ->
        IO.puts("Player 2 wins #{inspect h2} of #{inspect h1}")
        send(pid2, {:take_cards, Enum.concat([pile,cards1,cards2])})
        dealer_loop(%War{game_state: :init,
                         players: [%{pid: pid1, cards: []},
                                   %{pid: pid2, cards: []}]})
    end
  end

  def dealer_loop(%War{players: players,
                       game_state: state} = war) when state == :init or state == :war do
    #IO.puts("Dealer loop ask for card : #{inspect cards_to_give(state)}")
    Enum.each(players,
              fn(%{pid: p}) -> send(p, {:give_cards, cards_to_give(state)}) end)
    wait_for_player_cards(war)
  end

  def wait_for_player_cards(%War{waiting_on: num,
                                 game_state: state} = war) when num == 0 and
                                                                state == :war do
    dealer_loop(war)
  end
  def wait_for_player_cards(%War{waiting_on: num} = war) when num == 0 do
    dealer_loop(%War{war | game_state: :battle})
  end
  def wait_for_player_cards(%War{players: [%{pid: pid1,
                                             cards: cards1} = p1,
                                           %{pid: pid2,
                                             cards: cards2} = p2],
                                 waiting_on: num} = war) do
    receive do
      {:i_lost, player} ->
        IO.puts("player #{inspect player} lost")
      {:take_cards, player, []} ->
        IO.puts("Dealer got empty cards from player #{inspect player} player loses")
      {:take_cards, ^pid1, cards} ->
        IO.puts("Dealer got cards #{inspect cards} from player #{inspect pid1}")
        p1 = %{p1 | cards: cards1 ++ cards}
        wait_for_player_cards(%War{war | players: [p1,p2],
                                         waiting_on: num - 1})
      {:take_cards, ^pid2, cards} ->
        IO.puts("Dealer got cards #{inspect cards} from player #{inspect pid2}")
        p2 = %{p2 | cards: cards2 ++ cards}
        wait_for_player_cards(%War{war | players: [p1,p2],
                                         waiting_on: num - 1})
    end
  end

  def player_loop(dealer,deck) do
    IO.puts("Player #{inspect self()} loop with a deck of #{inspect deck}")
    receive do
      {:give_cards, _num_cards} when deck == [] ->
        IO.puts("I lost #{inspect self()}")
        send(dealer,{:i_lost, self()})
      {:give_cards, num_cards} ->
        IO.puts("Player #{inspect self()} rcvd give new cards #{inspect num_cards}")
        {cards_to_give,rest} = Enum.split(deck,num_cards)
        send(dealer,{:take_cards, self(), cards_to_give})
        player_loop(dealer,rest)
      # add new cards at bottom of deck
      {:take_cards, new_cards} ->
        IO.puts("Player #{inspect self()} rcvd new cards #{inspect new_cards}")
        player_loop(dealer,deck ++ new_cards)
      msg ->
        IO.puts("Player #{inspect self()} rcvd an unexpected message #{inspect msg}")
    end
  end
end
