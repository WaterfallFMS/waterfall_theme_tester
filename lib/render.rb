class Render < Base

  desc 'create_views', 'Creates the views directory'
  def create_views
    Dir.mkdir file_path('views') unless File.exists? file_path('views')
    say_status :created, 'views'
  end

  desc 'all', 'Renders all layouts into views'
  def all
    say 'Rendering'
    invoke :create_views

    bodies.each do |b|
      layouts.each do |f|
        render f, b
      end
    end
  end

  no_tasks do
    def location
      # simulate a location liquid object
      {}
    end

    def render(layout,body)
      input  = file_path('layouts',layout)
      output = output_file layout, body

      unless File.exists? input
        say_status :missing, layout, :yellow
      end

      open(input) do |f|
        template = Liquid::Template.parse f.readlines.join
        open(output,'w') do |out|
          out.write template.render :location => location, :layout_dir => file_path('layouts'), :body_file => body
        end
      end
      say_status :rendered, output, :green
    rescue Errno::ENOENT
      say_status :skipping, input, :yellow
    end

    def bodies
      return ['body'] unless options[:'all-bodies']

      ['body'].concat(files_in('test_data','bodies','*.html').map{|f| File.join('bodies',File.basename(f.gsub('.html','')))}).compact
    end

    def layouts
      ['index.html','application.html','franchise.html','franchise_index.html','login.html','store.html']
    end

    def output_file(layout, body_file)
      dir  = body_file == 'body' ? '1' : File.basename(body_file).gsub('.html','')
      name = File.basename(layout)

      file_path('views',[dir,name].compact.join('_'))
    end
  end
end