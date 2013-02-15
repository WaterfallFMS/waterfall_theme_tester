module WaterfallThemeTester
  module Liquid
    class YieldPartial < ::Liquid::Tag
      include FileBehavior

      def initialize(tag,layout,tokens)
        super
        @layout = layout.strip
      end

      def render(context)
        out = nil
        open(partial_name(@layout,context)) do |f|
          out = ::Liquid::Template.parse(f.readlines.join).render context
        end
        out
      end
    end
  end
end

::Liquid::Template.register_tag('yield_partial', WaterfallThemeTester::Liquid::YieldPartial)