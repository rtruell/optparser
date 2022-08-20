# optparser
Command line option parser

This started off life as an [answer](https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash/29754866#29754866) by Robert Siemer to a question on Stack Overflow about parsing command line options in `bash`...and then I completely rewrote nearly all of it, keeping only a couple of small portions.

After I got my new parser about half done, I ran into the problem of determining which option had just been set...was it a long option or a short one?&emsp;The same [DDG](https://duckduckgo.com) (DuckDuckGo) search for parsing command line options that had gotten me Robert's script had also turned up [`bash-getopt`](https://gist.github.com/smhmic/9841936) by Stephen Harris.&emsp;I really liked his idea of passing information about the calling program's options, including a variable name into which the value of an option was to be put (thus eliminating the question of whether a short or long option had been set), to the parser and allowing the parser to create the valid long and short option lists to be passed to `getopt`, as well as the help/usage message.

So why didn't I just use `bash-getopt` since it was ready-to-go and did pretty much everything I wanted `optparser` to do?&emsp;Because it, and every other option parser I looked at, suffers from what I consider to be a fatal problem: if an option requiring an argument is given and is followed, for whatever reason, by another option rather than the expected argument, then that next option is swallowed by the previous one as its argument (and obviously isn't processed) and no error is generated...which causes the calling program to not function in the expected way.&emsp;Since I'd already written code for `optparser` to get around this problem (the next option is left alone and the option requiring an argument is checked to see if a default value has been provided for it...if one has, it's used and `optparser` continues on, and if one hasn't, the option is added to the options-without-an-argument list and an error is generated), it was easier to adapt the concepts of `bash-getopt` that I liked to `optparser` than it was to figure out how and where to fix the problem in `bash-getopt`.

It may be important to note that while I may have implemented some of the *concepts* from `bash-getopt`, I didn't use **any** of the **code** from the gist linked to above.&emsp;Any similarity or exactness in code between the two programs really is coincidental.&emsp;Great minds do think alike :-)

And so....`optparser` was born.

# Requirements
# Useage
# Options
# Features
# Installation
# License
`optparser` is open-source software, released with an AGPL-3.0+ license.

See [LICENSE](LICENSE) for more details.
# Release Notes
See [CHANGELOG.md](CHANGELOG.md) for detailed release notes.
