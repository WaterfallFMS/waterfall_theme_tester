module WaterfallThemeTester
  module Liquid
    class YieldPartial < ::Liquid::Tag
      def initialize(tag,layout,tokens)
        super
        @layout = layout.strip
      end

      def render(context)
        out = nil
        open(file_name(@layout,context)) do |f|
          out = ::Liquid::Template.parse(f.readlines.join).render context
        end
        out
      end

      def layout_dir(context)
        context.environments.each do |env|
          return env[:layout_dir] if env.has_key? :layout_dir
        end
        nil
      end

      def file_name(layout,context)
        File.join(layout_dir(context),"_#{layout}.html")
      end
    end
  end
end

::Liquid::Template.register_tag('yield_partial', WaterfallThemeTester::Liquid::YieldPartial)