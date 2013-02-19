module WaterfallThemeTester
  module Liquid
    module FileBehavior
      def env_variable(variable, context)
        context.environments.each do |env|
          return env[variable] if env.has_key? variable
        end
        nil
      end

      def layout_dir(context)
        env_variable :layout_dir, context
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
