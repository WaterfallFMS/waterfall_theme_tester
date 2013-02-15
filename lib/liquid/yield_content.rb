module WaterfallThemeTester
  module Liquid
    class YieldContent < ::Liquid::Tag
      include FileBehavior

      def initialize(tag,layout,tokens)
        super
        @layout = layout.strip
      end

      def render(context)
        return lorem_ipsum unless File.exists? data_name(@layout,context)

        lines = []
        open(data_name(@layout,context)) do |f|
          lines = f.readlines
        end
        lines.join
      end

      def lorem_ipsum
        x = <<EOF
<p>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sit amet sollicitudin leo. Sed eu tortor magna, sed suscipit dui. Aenean dictum, mi vitae tempor aliquam, ante neque vehicula lacus, eu gravida justo felis sed nisl. Phasellus aliquet elit non ipsum sagittis ac mollis eros fermentum. Fusce venenatis aliquet augue non tincidunt. Aliquam justo diam, tincidunt ut pharetra sed, sodales at mauris. Donec nec ante augue, eu varius justo. In ut tortor nec nunc interdum viverra ac nec mi. Morbi interdum cursus ipsum, eu elementum enim mattis quis. Donec molestie faucibus dapibus. Vivamus in lectus neque, ut luctus ligula. Aliquam fermentum porttitor pharetra.
</p>
EOF
        x
      end
    end
  end
end

::Liquid::Template.register_tag('yield_content', WaterfallThemeTester::Liquid::YieldContent)