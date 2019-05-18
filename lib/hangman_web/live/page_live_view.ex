defmodule HangmanWeb.PageLiveView do
  use Phoenix.LiveView
  alias Diet.Stepper

  def render(assigns) do
    HangmanWeb.PageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket |> assign_game()}
  end

  def handle_event("guess", %{"letter" => l}, socket) do
    {r, s} = Stepper.run(socket.assigns.stepper, {:make_move, l})
    {:noreply, socket |> assign_game(s) |> assign_reply(l, r)}
  end

  def handle_event("new-game", _, socket) do
    {:noreply, socket |> assign_game()}
  end

  defp assign_game(socket), do: assign_game(socket, Stepper.new(Hangman, Hangman.Words.pick()))

  defp assign_game(socket, stepper) do
    socket
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
    |> assign(:continue, true)
    |> assign(:letter, nil)
  end

  defp assign_reply(socket, letter, reply) do
    socket
    |> assign(:move_reply, reply)
    |> assign(:letter, letter)
    |> assign(
      :continue,
      case reply do
        :game_won -> false
        :game_lost -> false
        _ -> true
      end
    )
  end

  defp body_part(num, s) do
    cond do
      s.model.turns_left == num -> :new
      s.model.turns_left < num -> :on
      s.model.turns_left > num -> :off
    end
  end
end
