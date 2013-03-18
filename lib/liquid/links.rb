module WaterfallThemeTester
  module Liquid
    class PageUrl < ::Liquid::Tag
      def initialize(tag,title,tokens)
        super
        @title = title
      end

      def render(context)
        tag_to_url
      end

    private
      def tag_to_url
        return page_title_url if @tag_name =~ /^page/
        '/' + @tag_name.gsub('_url','').gsub('_link','')
      end

      def page_title_url
        return '/pages' if @tag_name =~/^pages/

        '/pages/' + @title.strip.gsub(' ','_').downcase
      end
    end

    class GenericLink < PageUrl
      def render(context)
        "<a href=#{tag_to_url}>#{@title.strip}</a>"
      end
    end
  end
end

::Liquid::Template.register_tag('page_url', WaterfallThemeTester::Liquid::PageUrl)
::Liquid::Template.register_tag('pages_url', WaterfallThemeTester::Liquid::PageUrl)
::Liquid::Template.register_tag('root_url', WaterfallThemeTester::Liquid::PageUrl)
::Liquid::Template.register_tag('blogs_url', WaterfallThemeTester::Liquid::PageUrl)
::Liquid::Template.register_tag('events_url', WaterfallThemeTester::Liquid::PageUrl)
::Liquid::Template.register_tag('jobs_url', WaterfallThemeTester::Liquid::PageUrl)
::Liquid::Template.register_tag('store_url', WaterfallThemeTester::Liquid::PageUrl)

::Liquid::Template.register_tag('page_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('root_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('blogs_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('events_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('jobs_link', WaterfallThemeTester::Liquid::GenericLink)
::Liquid::Template.register_tag('store_link', WaterfallThemeTester::Liquid::GenericLink)