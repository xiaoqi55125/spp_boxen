### Notes on our developer setup post Mavericks upgrade

 - Accessability API needs to be re-enabled for shift-it. [The option location has changed.](http://forums.macrumors.com/showthread.php?t=1613755)
 - Full build passed `ber fast` except for jasmine phantomjs, which just seems to hang.
 - There's a potential issue related to homebrew and 10.9 that causes certain libraries not to compile. The temporary fix is to comment [this](https://github.com/mxcl/homebrew/blob/master/Library/Homebrew/build.rb#L174) out. They plan on making the compiler checking less stringent which will fix it long term.
