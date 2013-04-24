# Swiper
A poor, roughly shod implementation of what would happen if Swiper the Fox took up programming staff directory databases.

This simple Ruby script *swipes* (haha, get it?) images from the web, writes them to the filesystem, and updates the database column that provided the URL with the file name. It relies an existing SQLite database.

There's another script in here (`differences.rb`) to compare two versions of the column, reporting those with newly added images.

Dora will never find them now!

## Notes
Requires `sqlite3`, which limits Swiper to Ruby 1.9 environments. (I think. Seems like the SQLite modules for Ruby are a little confused themselves.)

If Swiper encounters invalid URLs in the supplied database column, it reports the failure and tries the next URL. In the case of such errors, the database and any existing images should remain unchanged.
