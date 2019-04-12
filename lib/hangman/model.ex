defmodule Hangman.Model do
  defstruct(
    word_to_guess: [],
    guessed_so_far: MapSet.new(),
    turns_left: 7
  )

  def build(word) do
    %__MODULE__{
      word_to_guess: word |> String.codepoints()
    }
  end

  def already_used_letter?(game, letter), do: letter in game.guessed_so_far
  def letter_in_word?(game, letter), do: letter in game.word_to_guess

  def use_letter(game, letter),
    do: %{game | guessed_so_far: MapSet.put(game.guessed_so_far, letter)}

  def game_won?(game) do
    game.word_to_guess
    |> Enum.reject(fn l -> already_used_letter?(game, l) end)
    |> Enum.empty?()
  end

  def one_less_turn(game), do: %{game | turns_left: game.turns_left - 1}

  def word_so_far(game) do
    game.word_to_guess
    |> Enum.map(fn l ->
      cond do
        l in game.guessed_so_far -> l
        :else -> "_"
      end
    end)
  end

  def out_of_turns?(game), do: game.turns_left == 0
end
