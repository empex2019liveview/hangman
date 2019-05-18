defmodule HangmanWeb.PageView do
  use HangmanWeb, :view

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

  defp top_message(assigns) do
    assigns[:move_reply]
    |> case do
      nil -> {:stop, "Welcome to hangman"}
      :game_won -> {:stop, "<span class=\"won\">Congratulations, you WON</span>"}
      :game_lost -> {:stop, "<span class=\"lost\">GAME OVER, you lose</span>"}
      :bad_guess -> {:continue, "Sorry, <span>#{assigns.letter}</span> not found!"}
      :good_guess -> {:continue, "Excellent, <span>#{assigns.letter}</span> found."}
      :already_tried -> {:continue, "Silly, you already guess <span>#{assigns.letter}</span>"}
      move_reply -> move_reply
    end
    |> case do
      {:stop, msg} ->
        msg

      {:continue, msg} ->
        case assigns.turns_left do
          1 -> "#{msg} (1 error remaining"
          0 -> "#{msg} (no errors remaining)"
          turns_left -> "#{msg} (#{turns_left} errors remaining)"
        end
    end
  end

  def colour(), do: @colours |> Enum.random()

  def person(:on), do: @colours |> Enum.random()
  def person(:off), do: "none"
  def person(:new), do: @hit
end
