module WaterfallThemeTester
  module Liquid
    class TitleTag < ::Liquid::Tag
      def initialize(tag,name,tokens)
        super
        @name = name.strip
      end

      def render(context)
        %Q[<title>example theme - #{@name}</title>]
      end
    end
  end
end

::Liquid::Template.register_tag('title_tag', WaterfallThemeTester::Liquid::TitleTag)
