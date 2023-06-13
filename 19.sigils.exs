# we've learned that elixir already provides double quoted strings
IO.puts("double quoted strings are FUN")

# and we've seen single quoted charlists
IO.puts('single quoted charlists are a thing too ...')
IO.puts("")

# sigils start with the tilde ~ character followed by a letter, and a delimiter
# the most common usecase is for regex, ~r
regex = ~r/foo|bar/
IO.puts("Can we use regexs to check for foo or bar ? #{"foo" =~ regex}")
IO.puts("Can we use regexs to solve world hunger? #{"bat" =~ regex}")
IO.puts("")

# we can use different delimters to support regexs
~r/hello/
~r|hello|
~r"hello"
~r'hello'
~r(hello)
~r[hello]
~r{hello}
~r<hello>

# we can use the ~s sigil to make strings without double quotes
IO.puts(~s(you crazy for this one, Rick!))

# we can create char list with ~c
IO.puts(~c(char lists are still ... acceptable))
IO.puts("")

# word lists with ~w
IO.puts(~w(this will make rubyists happy))
IO.puts("")

# would you believe sigils support heredoc too ?
IO.puts(~s"""
  My name is Ozymandias, King of kings:
  Look on my works, Ye Mighty, and despair!
  """)

# is it cool to create dates with a sigil ???
birthday = ~D[2014-07-15]
IO.puts("Woden's birthday is #{birthday}")

# what about times ?
standup = ~T[09:06:00.0]
IO.puts("when is standup ? #{standup}")

# naive date times ? 😰
naive_datetime = ~N[2019-10-31 23:00:07]
IO.puts("Let's celebrate halloween at #{naive_datetime}")

# UTC for the win
pivotal = ~U[2013-04-01 09:06:00Z]
IO.puts("when did pivotal start ? #{pivotal}")
IO.puts("")

# we can make our OWN sigils ???
# defmodule MySigils do
#   def sigil_m(direction, []), do: "🚢 => " <> destination
# end
# import MySigils
# 
# IO.puts("let's go to #{~m(Bordeaux)}")
# IO.puts("")
