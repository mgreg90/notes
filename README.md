# notes

notes is a [playwright-cli](https://github.com/mgreg90/playwright-cli) script.

Notes is a simple cli for writing notes on the current feature you're working
on. After creating a feature branch, just run:

```shell
$ notes
```

It'll create a branch-specific markdown file for you to keep notes in. Just run
the command whenever you want to open that file for edits.

and a notes file for the current git bran

## Installation

This script relies on the playwright-cli gem. Sharing features are still
in development for playwright, so for now, you'll need to run the following
commands to install it.

```shell
$ gem install playwright-cli
$ mkdir -p "$HOME/.playwright/plays"
$ cd "$HOME/.playwright/plays" && git clone git@github.com:[GIT_USERNAME]/notes.git
$ ln -s "$HOME/.playwright/plays/notes/notes.rb" "/usr/local/bin/notes"
```

In the future, expect a `$ playwright get notes` command to exist.

## Usage

This is literally the only command:
```shell
$ notes
```

## Thanks!

Thanks for checking out my script. If you're interested in ruby scripting,
consider creating a [playwright-cli](https://github.com/mgreg90/playwright-cli) script of your own!