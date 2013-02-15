module WaterfallThemeTester
  module Liquid
    module FileBehavior
      def layout_dir(context)
        context.environments.each do |env|
          return env[:layout_dir] if env.has_key? :layout_dir
        end
        nil
      end

      def partial_name(layout,context)
        File.join(layout_dir(context),"_#{layout}.html")
      end

      def data_name(layout,context)
        File.join(layout_dir(context),'..','test_data',"#{layout}.html")
      end
    end
  end
end
