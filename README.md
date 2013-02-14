Waterfall Theme Tester
======================

Tests Waterfall themes for common issues that prevent import.  Also, provides a simple renderer to allow basic manual testing.

Usage
=====

    git clone https://github.com/WaterfallFMS/waterfall_theme_tester.git
    gem install bundler
    bundle install
    sh waterfall_test_theme --dir=/path/to/your/theme

As an executable
----------------
The theme tester can be run as a command on linux system.  If you think that "./" is easier then "sh ".

    chmod +x waterfall_test_theme
    ./waterfall_test_theme --dir=/path/to/your/theme


Checking
========
A theme is can be checked but not rendered by using the `check` command.

    sh waterfall_test_theme check --dir=/some/theme

Rendering
=========
A theme can be rendered without checking by using the `render` command.

    sh waterfall_test_theme render --dir=/some/theme