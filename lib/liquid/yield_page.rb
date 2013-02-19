module WaterfallThemeTester
  module Liquid
    class YieldPage < YieldContent
      def render(context)
        @layout = env_variable :body_file, context

        super
      end

      def lorem_ipsum
        x = <<EOF
<p>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sit amet sollicitudin leo. Sed eu tortor magna, sed suscipit dui. Aenean dictum, mi vitae tempor aliquam, ante neque vehicula lacus, eu gravida justo felis sed nisl. Phasellus aliquet elit non ipsum sagittis ac mollis eros fermentum. Fusce venenatis aliquet augue non tincidunt. Aliquam justo diam, tincidunt ut pharetra sed, sodales at mauris. Donec nec ante augue, eu varius justo. In ut tortor nec nunc interdum viverra ac nec mi. Morbi interdum cursus ipsum, eu elementum enim mattis quis. Donec molestie faucibus dapibus. Vivamus in lectus neque, ut luctus ligula. Aliquam fermentum porttitor pharetra.
</p><p>
Suspendisse rhoncus posuere erat, ac accumsan erat convallis quis. Suspendisse sollicitudin metus in odio ultrices pharetra. Duis in ante vitae orci ultrices accumsan vel varius eros. Quisque luctus commodo purus, et commodo massa aliquam nec. Nullam non risus ligula. Phasellus lacus justo, molestie eget imperdiet auctor, accumsan pulvinar velit. Aliquam non elit nisl, vitae suscipit elit. Fusce tempus consectetur bibendum. Nullam pretium odio non lacus posuere vitae scelerisque tortor lacinia. Nunc fringilla turpis ac tortor accumsan malesuada congue augue euismod. Nunc tempus consequat porta. Aenean libero libero, consectetur a porttitor quis, sodales at magna. Fusce venenatis neque ac mauris pellentesque quis posuere nibh adipiscing. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc rhoncus vulputate blandit. Fusce pellentesque interdum scelerisque.
</p><p>
Morbi a nisi eu ante semper dapibus ac in libero. Donec felis est, mollis in pretium ac, consectetur in erat. Curabitur porttitor massa at mauris hendrerit sed rhoncus eros bibendum. Donec in lorem non urna lobortis aliquam. Nulla facilisi. Mauris eget lectus metus. Mauris id purus at leo malesuada ultricies. Suspendisse auctor, sem in suscipit aliquet, neque elit posuere sem, sed pretium mauris massa ultrices nulla. Vestibulum mattis sapien sit amet eros bibendum molestie. Pellentesque tempor placerat nulla, sit amet pharetra tortor euismod at. Nunc in libero et est cursus faucibus. Nulla gravida elementum condimentum. Maecenas quam libero, dapibus ut porta et, aliquet non dolor.
</p><p>
Mauris quis dui in risus sollicitudin eleifend ut et mi. Quisque pellentesque nunc ut sapien commodo venenatis. Cras ultrices pulvinar enim eu hendrerit. Sed consectetur adipiscing dui nec pretium. Donec ac dolor lectus. Donec dolor massa, ultrices ornare faucibus in, lobortis sit amet urna. Sed et tellus lectus, ac consectetur quam. Fusce egestas tempor dui et faucibus. Proin dictum rhoncus eros id tristique. Sed rutrum risus leo. Mauris porta, est vitae faucibus blandit, massa leo commodo nunc, sed euismod lacus nulla et augue. Aenean varius hendrerit orci eget vestibulum. Ut nisl turpis, facilisis ut vulputate nec, dapibus sed odio. Phasellus vel elit metus. Aenean porta scelerisque massa et gravida.
</p><p>
Quisque mi ante, laoreet id cursus vehicula, tempor eu sem. Duis ut justo sem. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam eu rhoncus metus. Donec condimentum dignissim fringilla. Fusce faucibus est eu dolor fermentum sed ultricies elit rhoncus. Vestibulum tempor, velit in bibendum feugiat, neque ipsum aliquam metus, vel mattis libero dui sed magna. Integer non ornare dui. Nunc enim massa, fringilla vitae eleifend in, feugiat quis lorem. Aliquam ac odio dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
</p>
EOF
        x
      end
    end
  end
end

::Liquid::Template.register_tag('yield_page', WaterfallThemeTester::Liquid::YieldPage)