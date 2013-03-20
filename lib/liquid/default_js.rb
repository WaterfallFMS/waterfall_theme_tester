module WaterfallThemeTester
  module Liquid
    class DefaultJS < ::Liquid::Tag
      def render(context)
        ['<script src="../javascripts/jquery.js" type="text/javascript"></script>',
         '<script src="../javascripts/fullcalendar.js" type="text/javascript"></script>'].join
      end
    end
  end
end

::Liquid::Template.register_tag('default_js', WaterfallThemeTester::Liquid::DefaultJS)