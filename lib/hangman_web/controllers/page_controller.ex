defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller
  alias Diet.Stepper

  def index(conn, _params) do
    s = Stepper.new(Hangman, "shawshank")
    {_r, s} = Stepper.run(s, {:make_move, "a"})
    {_r, s} = Stepper.run(s, {:make_move, "z"})
    {_r, s} = Stepper.run(s, {:make_move, "w"})
    {_r, s} = Stepper.run(s, {:make_move, "o"})
    {_r, s} = Stepper.run(s, {:make_move, "x"})
    {r, s} = Stepper.run(s, {:make_move, "y"})

    conn
    |> assign_game(s)
    |> assign_reply("y", r)
    |> render("index.html")
  end

  defp assign_game(conn), do: assign_game(conn, Stepper.new(Hangman, "shawshank"))

  defp assign_game(conn, stepper) do
    conn
    |> assign(:stepper, stepper)
    |> assign(:rope, body_part(6, stepper))
    |> assign(:head, body_part(5, stepper))
    |> assign(:body, body_part(4, stepper))
    |> assign(:left_arm, body_part(3, stepper))
    |> assign(:right_arm, body_part(2, stepper))
    |> assign(:left_leg, body_part(1, stepper))
    |> assign(:right_leg, body_part(0, stepper))
    |> assign(:answer, stepper.model.word_to_guess |> Enum.join())
    |> assign(:turns_left, stepper.model.turns_left)
    |> assign(:word_so_far, Hangman.Model.word_so_far(stepper.model))
    |> assign(:move_reply, nil)
    |> assign(:letter, nil)
  end

  defp assign_reply(socket, letter, reply) do
    socket
    |> assign(:move_reply, reply)
    |> assign(:letter, letter)
  end

  defp body_part(num, s) do
    cond do
      s.model.turns_left == num -> :new
      s.model.turns_left < num -> :on
      s.model.turns_left > num -> :off
    end
  end
end
