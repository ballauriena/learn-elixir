defmodule CardsTest do
    use ExUnit.Case
    doctest Cards

    test "create_deck makes 52 cards" do
        deck_length = length(Cards.create_deck)
    	assert deck_length == 52
    end

    test "shuffling a deck randomizes it" do
        deck = Cards.create_deck
        refute deck == Cards.shuffle(deck)
    end

    test "create_hand returns a hand of the given hand_size and a remaining deck of the proper size" do
        {hand, remaining_cards} = Cards.create_hand(5)
        assert length(hand) == 5
        assert length(remaining_cards) == 47
    end

    test "save saves a deck to a new tmp file" do
        Cards.create_deck
        |> Cards.save("my_deck")
        {success, _} = File.read("tmp/my_deck")

        assert success == :ok
    end

    test "load loads a deck from a file" do
        deck = Cards.create_deck
        Cards.save(deck, "my_deck")
        loaded_deck = Cards.load("my_deck")

        assert loaded_deck == deck
    end
end
