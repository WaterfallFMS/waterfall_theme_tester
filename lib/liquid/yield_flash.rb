module WaterfallThemeTester
  module Liquid
    class YieldFlash < ::Liquid::Tag
      def render(context)
        div('This is a message','messages') +
        div('This is an error', 'error') +
        div('This is a warning', 'warning') +
        div('This is a notice', 'notice')
      end

      def div(text,klass)
        %Q[<div class="#{klass}">#{text}</div>]
      end
    end
  end
end

::Liquid::Template.register_tag('yield_flash', WaterfallThemeTester::Liquid::YieldFlash)