# Hangman

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

```
alias Diet.Stepper
s = Stepper.new Hangman, "wombat"; :ok
{r, s} = Stepper.run s, {:make_move, "a"}; r
{r, s} = Stepper.run s, {:make_move, "w"}; r
{r, s} = Stepper.run s, {:make_move, "o"}; r
{r, s} = Stepper.run s, {:make_move, "x"}; r
Hangman.Model.word_so_far(s.model)
{r, s} = Stepper.run s, {:make_move, "m"}; r
{r, s} = Stepper.run s, {:make_move, "t"}; r
{r, s} = Stepper.run s, {:make_move, "b"}; r
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
