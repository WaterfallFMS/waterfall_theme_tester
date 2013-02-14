class Render < Base

  desc 'create_views', 'Creates the views directory'
  def create_views
    Dir.mkdir file_path('views')
    say_status :created, 'views'
  rescue
    say_status :skip, 'views'
  end

  desc 'all', 'Renders all layouts into views'
  def all
    say 'Rendering'
    invoke :create_views
    ['index.html','application.html','franchise.html','franchise_index.html','login.html','store.html'].each do |f|
      render f
    end
  end

  no_tasks do
    def location
      # simulate a location liquid object
      {}
    end

    def render(layout)
      input  = file_path('layouts',layout)
      output = file_path('views',layout)

      unless File.exists? input
        say_status :missing, layout, :yellow
      end

      open(input) do |f|
        template = Liquid::Template.parse f.readlines.join
        open(output,'w') do |out|
          out.write template.render :location => location, :layout_dir => file_path('layouts')
        end
      end
      say_status :rendered, layout, :green
    end
  end
end