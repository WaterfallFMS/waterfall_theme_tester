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

Rendered layouts are placed in /views with the same name as the layout.  All expressions will be removed so they are fully valid HTML.

Theme
========
A sample theme can be found at: https://github.com/WaterfallFMS/example_theme.  However you can roll your own if you want.

Layout
------

  /base
    /images
    /stylesheets
    /javascripts
    /layouts
      application.html
      ...
    /test_data
      some_content.html

Expressions
-----------
A modified version of the Liquid Tempalate language is used to simulate the dynamic nature of layouts.  More details can be found at http://liquidmarkup.org/.

### Basic Syntax
Variables can be accessed using `{{ variable }}`.

Tags can be accessed using `{% tag args %}`

### Location variable
We add a `location` for use on franchise layouts.  It simulates the behavior that Franchise content and pages in waterfall have.

### Additional Tags
Waterfall data is dynamic and therefore changes.  We provide the following tags to eliminate static behavior which will break in production.

#### Link Tags
We provide the following link tags which should be used in themes instead of links to internal pages.


`{% page_url Page title %}` - Finds the page by title (case sensitive) and provides the URL to it.  If not found it provides the location root or corporate root, depending on site.  Your IA document should define all the pages for all the sites that are valid.

`{% page_link Page title %}` - Like `page_url` but wraps the behavior in a link.

`{% blog_link Title %}` - Links to the blog for the site.

`{% events_link Title %}` - Links to the events for the site.

`{% jobs_link Title %}` - Links to the jobs for the site.

`{% store_link Title %}` - Links to the store for the site (franchise only).

#### yield_content
`{% yield_content Content type %}` finds and renders the content of a content type.  These are useful if there are small configuraiton that need to be made site wide, like the providing an Ad iframe.  All content types should be defined in the IA.

##### Simulating actual content
If you puts a file in `/test_data` with the same name as the content type and the extention ".html" then it will be used when that content type is called out.  This is a simplified to ensure that content styles are applied correctly.

If no test data is supplied then it defaults to 1 paragraph of lorem ipsum.

Example:

  {% yield_content Help %}

  /test_data
    Help.html

#### yield_page
`{% yield_page %}` is similar to `yield_content` but only one can exist for any layout and it is the main content for that layout.  Therefore you cannot call out what content to load.

##### Simulating actual content
Similar to `yield_content` you can add a file to `/test_data` to be rendered as the body.  The file is `body.html`.

If no `body.html` is provided then 5 paragraphs of lorem ipsum are provided.

#### yield_partial
Due to the nature of HTML there is a lot repeats between layouts.  This is solved by taking repeated segments and moving them into a partial.  A partial is just an html file starting with "_".  For exmple, "_head.html" is a common partial that would define the stylesheet, and javascript links; which don't generally change per page.

 Example:

`layouts/_head.html`

     <link href="../images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
     <link rel="stylesheet" type="text/css" href="../stylesheets/theme.css">


`layouts/application.html`

    <html>
      <head>
        {% yield_partial head %}
      </head>
      ...
    </html>


`views/application.html` (after rendering)

    <html>
      <head>
        <link href="../images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="../stylesheets/theme.css">
      </head>
      ...
    </html>
