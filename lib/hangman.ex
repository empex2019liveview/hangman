defmodule Hangman do
  use Diet.Transformations,
    model: Hangman.Model,
    as: HM

  reductions(debug: false, model_name: :game) do
    {:make_move, move} ->
      {:make_move, move, HM.already_used_letter?(game, move)}

    {:make_move, _move, true} ->
      :already_tried

    {:make_move, move, _} ->
      {:record_move, move}

    {:record_move, move} ->
      update_model(HM.use_letter(game, move)) do
        {:maybe_match, move}
      end

    {:maybe_match, move} ->
      {:maybe_match, move, HM.letter_in_word?(game, move)}

    {:maybe_match, _move, true} ->
      :match

    {:maybe_match, _move, _} ->
      :no_match

    :match ->
      {:match, HM.game_won?(game)}

    {:match, true} ->
      :game_won

    {:match, _} ->
      :good_guess

    :no_match ->
      {:no_match, HM.out_of_turns?(game)}

    {:no_match, true} ->
      :game_lost

    {:no_match, _} ->
      update_model(HM.one_less_turn(game)) do
        :bad_guess
      end

    :word_so_far ->
      {:the_word, HM.word_so_far(game)}
  end
end
