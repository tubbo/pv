# PV

Use Pivotal Tracker in the shell.

## Installation

Install the binary:

    $ gem install pv

Then create `~/.pv` with your deets:

```yaml
username: user@email.com
password: your-super-secret-password
project_id: 123456
name: 'Your Name'
```

Or, run `pv config`.

## Usage

Here are all of the commands PV can do:

![pv log](http://i.imgur.com/JJKDu.png)
### pv

Simply running `pv` will open your `$PAGER` with the stories
in your "My Work" tab. Each story is one line and includes the 
title and the ID:

    123456   My spoon is too big. (A Banana)

![pv show](http://i.imgur.com/hIKrs.png)
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

![pv help](http://i.imgur.com/RxzuQ.png)
### pv help

Show a command manual.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
