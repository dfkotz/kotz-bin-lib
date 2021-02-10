#!/bin/sh
# check the internal and external links on my wordpress website

linkchecker --check-extern\
            --ignore-url=dfkotz.files.wordpress.com\
            --ignore-url=.wp.com\
            --ignore-url=https://wp.me/\
            --ignore-url=javascript:\
            --ignore-url=davidkotz.org/xmlrpc.php\
            --ignore-url=davidkotz.org/category/\
            --ignore-url=davidkotz.org/tag/\
            --ignore-url=facebook.com\
            --ignore-url=twitter.com\
            --ignore-url=share=facebook\
            --ignore-url=share=twitter\
            https://davidkotz.org\
    | tee ~/Desktop/davidkotz-linkchecker.txt 
