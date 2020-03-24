# Hashketball

## Learning Goals

* Practice building nested hashes

## Instructions

This and the next lab are about as representative of real-life tasks as a
programmer as you can get: data on paper or in tables needs to be given to a
programming language to deliver _insights_.

Your task is to perform an analysis on an NBA game. You've been provided some
basic game data in a series of tables. Your goal is use Ruby to help you answer
some questions about the game, but before we can work with the data, we
need to put it in a useful format.

This challenge comes in two major pieces:

1. Build a nested data structure from text and data stored in tables
2. Process the nested data structure to produce _insights_ about how various
   players performed

While you've worked with nested data structures using simple looping and
Enumerables, you've never before had to _create_ such a complex nested data
structure **and** _process_ it as well. We've split this challenge into two labs
so you can just focus on the first task here - building the NDS.

Code your solution in `hashketball.rb` following the steps below. Because this
lab is so big, we'll show you new techniques for running only small chunks of
the test suite so that you're not overwhelmed by all the test data!

## Step 1: Building the Hash

There is one method in this lab to implement: `game_hash`. This method contains and
returns a hash nested in the following manner:

* The top level of the hash has two keys: `:home`, for the home team, and
  `:away`, for the away team.
* The values of the `:home` and `:away` keys are hashes. These hashes have the
  following keys:
  * `:team_name`
  * `:colors`
  * `:players`
* The `:team_name` key points to a string of the team name.
* The `:colors` key points to an array of strings that are that team's colors.
* The `:players` key points to an `Array` of `Hash`es. Each `Hash` in the `Array`
  should contain the players' stats. Each stat should be a key that points to
  a value for that stat. The keys should be:
  * `:player_name`
  * `:number`
  * `:shoe`
  * `:points`
  * `:rebounds`
  * `:assists`
  * `:steals`
  * `:blocks`
  * `:slam_dunks`
* The data for each player is provided in a table below.

Home Team:

* team name: Brooklyn Nets
* colors: Black, White
* players:

|          Stat          | Info | Info |  Info | Info | Info   |
|:------------------:|:-------------:|:------------:|:------------:|:-------------:|:-------------:|
| **Player Name**    |  Alan Anderson| Reggie Evans | Brook Lopez  | Mason Plumlee | Jason Terry   |
| **Number**         | 0             | 30           | 11           | 1             | 31            |
| **Shoe**           | 16            | 14           | 17           | 19            | 15            |
| **Points**         | 22            | 12           | 17           | 26            | 19            |
| **Rebounds**       | 12            | 12           | 19           | 11            | 2             |
| **Assists**        | 12            | 12           | 10           | 6             | 2             |
| **Steals**         | 3             | 12           | 3            | 3             | 4             |
| **Blocks**         | 1             | 12           | 1            | 8             | 11            |
| **Slam Dunks**     | 1             | 7            | 15           | 5             | 1             |

Away Team:

* team name: Charlotte Hornets
* colors: Turquoise, Purple
* players:

|        Stat       |     Info          |         Info     |              Info |         Info     |         Info      |
|:------------------:|:-----------------:|:-----------------:|:-----------------:|:---------------:|:-----------------:|
| **Player Name**  | Jeff Adrien     | Bismack Biyombo    | DeSagna Diop      | Ben Gordon      | Kemba Walker   |
| **Number**         | 4                 | 0                 | 2                 | 8               | 33                |
| **Shoe**           | 18                | 16                | 14                | 15              | 15                |
| **Points**         | 10                | 12                | 24                | 33              | 6                 |
| **Rebounds**       | 1                 | 4                 | 12                | 3               | 12                |
| **Assists**        | 1                 | 7                 | 12                | 2               | 12                |
| **Steals**         | 2                 | 22                 | 4                 | 1               | 7                |
| **Blocks**         | 7                 | 15                | 5                 | 1               | 5                 |
| **Slam Dunks**     | 2                 | 10                | 5                 | 0               | 12                |

Write a method called `game_hash` that returns your nested data structure. We
might suggest starting with having `game_hash` return only a `{}`. Then run the
`game_hash` tests (see next section) and slowly build up your nested data
structure to satisfy those tests. We'll describe the strategy here in the next
sections.

### Process Tip: Writing Nested Data Structures is Hard

Writing nested data structures is challenging because we humans can lose track
of whether or not we closed a `{...}` set or added a `,` in the right place.
Running a small chunk of tests (more on that in the next section ) to make sure
our nested data structure is _syntactically valid_ (i.e. honors Ruby's grammar
rules) is a good idea. This allows a process like:

* Start with something _syntactically valid_, but _incorrect_ e.g. `{}`
* Make an edit
* run the tests
* Is the nested data structure valid? Great!
* Make another edit
* Run the tests...error!
* Add missing comma
* Add the comma
* Run tests...
* Working again!

Syntactically valid, but _incorrect_ nested data structures are easier to
correct than to fix _syntactically invalid_ ***and*** _incorrect_ nested data
structures.  Constantly asking Ruby "Hey can you read this?" means that you're
never have a mountain of things that are broken...maybe small,
more-easily-fixed little pile.

Once you have a _syntactically valid,_ but _incorrect_ nested data structure,
you can slowly add to the nested data structure and move it to being _correct_.
A key strategy to iterating towards _correctness_ is running a small subset of
tests to have _Ruby_ validate our nested data structure instead of our
error-prone human eyes.

### Process Tip: Run Only a Few Tests

When we have a lot of tests and run them all with `learn` and get back all
those failing messages it can make us feel sad. It's like telling someone
you're trying to learn an étude on piano and they keep telling you it's not
perfect yet. "Yeah, we know, that's why we said we're _l-e-a-r-n-i-n-g_ it."

We can run a specific test by running RSpec on the spec file, then adding a
colon and the line number where the test is located in the file. The following,
for example, will run first test in the lab only:

`rspec spec/hashketball_spec.rb:50`

But changing the line to `54` will run the second test only:

`rspec spec/hashketball_spec.rb:54`

The remaining three tests in this lab are on lines `60`, `66`, and `82`.
Alternative, if you want to run a section of tests, you can do so using the
following command from the CLI:

`rspec spec/hashketball_spec.rb -e game_hash`

The thing that lets us run only a portion of the test suite is the `-e` for
`--example` flag. It means "only run tests in a section that matches the word
`game_hash`." You can read more about it in the [RSpec documentation for `--example`][example].

In this example, since we only have one section of tests, this command outputs
the same results as running `learn`. 

The `learn` program uses `rspec` to evaluate test success. So, if we get a
subset of the tests working, as proved by `rspec`, we can trust that those tests
will pass when we run `learn`.

> **Wisdom**: Move from working to working to working. Never let "broken in
> this way, and that way, and that way" mount up!

## Conclusion

With the data structured into a nested data structure, we can move on to working
with the data and drawing out information.

Work where you processed `Array` of `Arrays` or `Array`s of `Hash`es would be
wise to freshen up on as preparation for the next lab. Take it in pieces,
remember your training, and you'll get there!

We also strongly recommend that you read the ***entire*** README before you
start coding. We're going to show some tips and tricks that make the coding a
lot easier...but only if you read through to the end.

## Resources

* [Rspec's example flag][example]
* [Working with nested Hashes in Ruby](http://www.korenlc.com/nested-arrays-hashes-loops-in-ruby/)

[example]: https://relishapp.com/rspec/rspec-core/v/2-12/docs/command-line/example-option#match-on-one-word
