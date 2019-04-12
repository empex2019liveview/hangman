defmodule HangmanWeb.PageLiveView do
  use Phoenix.LiveView
  alias Diet.Stepper

  @colours [
    "#5ED0FA",
    "#54D1DB",
    "#A368FC",
    "#F86A6A",
    "#FADB5F",
    "#65D6AD",
    "#127FBF",
    "#0E7C86",
    "#690CB0",
    "#AB091E",
    "#CB6E17",
    "#147D64"
  ]

  @hit "#D64545"

  def render(assigns) do
    ~L"""
    <div class="hangman" data-cheater=<%= @answer %>>
      <div class="move-reply">
        <%= Phoenix.HTML.raw(case @move_reply do
              nil -> "Welcome to hangman"
              :bad_guess -> "Sorry, <span>#{@letter}</span> not found!"
              :good_guess -> "Excellent, <span>#{@letter}</span> found."
              :game_won -> "WON"
              :game_lost -> "GAME OVER, you lose"
              :already_tried -> "Silly, you already guess <span>#{@letter}</span>"
              _ -> @move_reply
            end) %>

        <%= case @turns_left do
              7 -> ""
              1 -> "(1 error remaining"
              0 -> "(no errors remaining)"
              _ -> "(#{@turns_left} errors remaining)"
            end %>
      </div>
      <svg width="159px" height="144px" viewBox="0 0 159 144" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <g id="hangman" stroke="none" stroke-width="1" fill-rule="evenodd">
          <g id="platform" fill="#D1D1D1">
            <polygon id="left" fill="<%= colour() %>" points="14 -7.66053887e-15 21 -7.66053887e-15 21 138 14 138"></polygon>
            <polygon id="bottom" fill="<%= colour() %>" transform="translate(79.500000, 141.000000) rotate(90.000000) translate(-79.500000, -141.000000) " points="76.5 61.5 82.5 61.5 82.5 220.5 76.5 220.5"></polygon>
            <polygon id="top" fill="<%= colour() %>" transform="translate(54.500000, 3.000000) rotate(90.000000) translate(-54.500000, -3.000000) " points="51.5 -51.5 57.5 -51.5 57.5 57.5 51.5 57.5"></polygon>
            <polygon id="rope" fill="<%= person(@rope) %>" points="109 -1.88737914e-15 116 -1.88737914e-15 116 34 109 34"></polygon>
          </g>
          <g id="person" transform="translate(83.000000, 34.000000)">
            <ellipse id="head" fill="<%= person(@head) %>" cx="29.5" cy="12" rx="14.5" ry="12"></ellipse>
            <rect id="body" fill="<%= person(@body) %>" x="26" y="23" width="7" height="36"></rect>
            <polygon id="left_arm" fill="<%= person(@left_arm) %>" transform="translate(17.887481, 35.964726) rotate(100.000000) translate(-17.887481, -35.964726) " points="14.387481 21.4647257 21.387481 21.4647257 21.387481 50.4647257 14.387481 50.4647257"></polygon>
            <polygon id="right_arm" fill="<%= person(@right_arm) %>" transform="translate(41.887481, 35.964726) rotate(80.000000) translate(-41.887481, -35.964726) " points="38.387481 21.4647257 45.387481 21.4647257 45.387481 50.4647257 38.387481 50.4647257"></polygon>
            <polygon id="left_leg" fill="<%= person(@left_leg) %>" transform="translate(16.449946, 69.449946) rotate(45.000000) translate(-16.449946, -69.449946) " points="13.9041271 50.860171 20.7936782 50.5299419 18.9957643 88.0397203 12.1062131 88.3699494"></polygon>
            <polygon id="right_leg" fill="<%= person(@right_leg) %>" transform="translate(42.449946, 71.449946) rotate(-45.000000) translate(-42.449946, -71.449946) " points="38.1062131 52.5299419 44.9957643 52.860171 46.7936782 90.3699494 39.9041271 90.0397203"></polygon>
          </g>
        </g>
      </svg>
      <div class="word">
        <%= for l <- @word_so_far do %>
          <span><%= l %></span>
        <% end %>
      </div>
      <div class="form">
        <form>
          <input name="letter" type="text" maxlength="1" />
          <input type="submit" class="btn-guess" value="Guess" />
          <button class="btn-new">New</button>
        </form>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, socket |> assign_game()}
  end

  defp assign_game(socket), do: assign_game(socket, Stepper.new(Hangman, "shawshank"))

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

  def colour(), do: @colours |> Enum.random()

  def person(:on), do: @colours |> Enum.random()
  def person(:off), do: "none"
  def person(:new), do: @hit
end
