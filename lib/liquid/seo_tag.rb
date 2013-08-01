module WaterfallThemeTester
  module Liquid
    class SEOTag < ::Liquid::Tag
      def render(context)
        ['<title>example theme</title>',
         '<meta name="description" content="sample SEO description">',
         '<meta name="keywords" content="sample SEO keywords">'].join("\n")
      end
    end
  end
end

::Liquid::Template.register_tag('seo_tags', WaterfallThemeTester::Liquid::SEOTag)