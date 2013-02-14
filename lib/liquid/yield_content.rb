module WaterfallThemeTester
  module Liquid
    class YieldContent < ::Liquid::Tag
      def render(context)
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