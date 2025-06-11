# Run Command (Runcom) Configuration

[What does "rc" ... stand for?](http://unix.stackexchange.com/questions/3467/what-does-rc-in-bashrc-stand-for)

> [Unix: from runcom files on the CTSS system 1962-63, via the startup script /etc/rc]
> Script file containing startup instructions for an application > program (or
> an entire operating system), usually a text file containing commands of the
> sort that might have been invoked manually once the system was running but are
> to be executed automatically each time the system starts up.<sup>[[1][source]]</sup>

All files are suffixed with `rc`, are typically non-executable and live in the `$HOME` directory. From the `$dotfiles` script, all files are forced as symlinks.

## List of Files

- [.ackrc](http://beyondgrep.com/documentation/)
- [.bashrc](http://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html)
- [.curlrc](http://curl.haxx.se/docs/manpage.html)
- [.inputrc](http://www.gnu.org/software/bash/manual/html_node/Readline-Init-File.html)
- [.wgetrc](https://www.gnu.org/software/wget/manual/html_node/Wgetrc-Commands.html)

[source]: http://www.catb.org/jargon/html/R/rc-file.html
