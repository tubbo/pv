# PV

Use Pivotal Tracker in the shell.

## Installation

Install the binary:

    $ gem install pv

Then create `~/.pivotal.yml` with your deets:

```yaml
username: user@email.com
password: your-super-secret-password
project: your-awesome-project-name
```

## Usage

Here are all of the commands Piv can do:

### pv

Simply running `piv` will open your `$PAGER` with the stories
in your "My Work" tab. Each story is one line and includes the 
title and the ID:

    123456   My spoon is too big. (A Banana)

### pv show 123456

Show the entire story's details, including tasks. Again, this is
viewed in your `$PAGER`...

    Feature 123456 (6 points)
    Requester: A Banana <banana@work.com>
    Owner: John Doe <someone@home.com>
    Status: NOT STARTED

    My spoon is too big.

    I AM A BANANA!


### pv edit 123456 -s {start|finish|deliver|accept|reject|restart|close} -m "message"

Edits the status of a given story on Pivotal Tracker, with an optional message. The
message is appended to the story in comments.

### pv {start|finish|deliver|accept|reject|restart|close} 123456 -m "message"

Easier-to-remember aliases for the above command.

### pv create "Story title" --points=3

Creates a story on Pivotal Tracker. Opens your `$EDITOR` so you can provide more information
than simply the title, unless you pass --minimal. Stories are created as features by default,
but you can override this by passing `--bug` or `--chore`. Note: `--points` values, while
required if creating a feature, are ignored when creating bugs or chores. They are also not
required on the command.

### pv help

Show a command manual.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
