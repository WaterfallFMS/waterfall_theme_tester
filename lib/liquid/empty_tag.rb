module WaterfallThemeTester
  module Liquid
    class EmptyTag < ::Liquid::Tag
      def render(context)
        %Q[<!-- #{@tag_name} goes here -->]
      end
    end
  end
end

::Liquid::Template.register_tag('analytics_tag', WaterfallThemeTester::Liquid::EmptyTag)
::Liquid::Template.register_tag('yield_head', WaterfallThemeTester::Liquid::EmptyTag)
::Liquid::Template.register_tag('yield_scripts', WaterfallThemeTester::Liquid::EmptyTag)