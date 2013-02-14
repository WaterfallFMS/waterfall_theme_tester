module WaterfallThemeTester
  module Liquid
    class GenericLink < ::Liquid::Tag
      def initialize(tag_name, title, tokens)
        super
        @title = title
      end

      def render(context)
        "<a href=/>#{@title.strip}</a>"
      end
    end
  end
end

::Liquid::Template.register_tag('page_url', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('page_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('blog_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('events_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('jobs_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('store_link', WaterfallThemeTester::Liquid::GenericLink)