class Check < Base
  class_option :dir
  desc 'admin_logo', 'Checks for the existence of an admin logo'
  def admin_logo
    if File.exists? file_path('images', 'admin-logo.png')
      say_status :found, 'images/admin-logo.png'
    else
      say_status :missing, 'images/admin-logo.png', :red
    end
  end

  desc 'favicon', 'Checks for the existance of a favicon'
  def favicon
    if File.exists? file_path('images', 'favicon.ico')
      say_status :found, 'images/favicon.ico'
    else
      say_status :missing, 'images/favicon.ico', :yellow
    end
  end

  desc 'image_files', 'Checks that correct file types exist in the images dir'
  def image_files
    files = files_in 'images', '**', '*'
    files.delete_if {|file| File.directory? file }
    files.delete_if {|file| file =~ /png$/}
    files.delete_if {|file| file =~ /jpeg$/}
    files.delete_if {|file| file =~ /jpg$/}
    files.delete_if {|file| file =~ /gif$/}
    files.delete_if {|file| file =~ /favicon.ico$/}
    files.each do |file|
      say_status 'bad image', file, :red
    end
  end

  desc 'unused_images', 'Lists all known unused images'
  def unused_images
    images = files_in('images', '**', '*')
    images.delete_if {|f| File.directory? f}
    images.delete_if {|f| f =~ /favicon.ico$/ }
    images.delete_if {|f| f =~ /admin-logo.png$/ }
    images = images.map {|file| file.gsub(dir,'').gsub('images','').gsub(/^\/*/,'')}.uniq
    
    images = images.inject({}) {|hash,image| hash[image] = false; hash}
    
    # images = %W(white-arrows.png)
    layouts = files_in('views','**','*.html*').
                concat(files_in('layouts','**','*.html*')).
                concat(files_in('stylesheets','**','*.css'))
    layouts.each do |file|
      open(file) do |f|
        lines = f.readlines
        images.each do |image,found|
          next if found
          unless lines.grep(/#{image}/).empty?
            images[image] = true
          end
        end
      end
    end
    
    images.each do |image,found|
      next if found
      say_status "unused image", file_path('images',image), :red
    end
  end

  desc 'javascript_files', 'Checks that correct file types exist in the javascripts dir'
  def javascript_files
    files = files_in 'javascripts', '**', '*'
    files.delete_if {|file| File.directory? file }
    files.delete_if {|file| file =~ /js$/ }
    files.each do |file|
      say_status 'bad js', file, :red
    end
  end

  desc 'no_jquery', 'Checks that jQuery doesn\'t exist'
  def no_jquery
    files_in('**','*jquery*').each do |file|
      say_status :jQuery, file, :yellow
    end
  end

  desc 'css_files', 'checks that correct file types exist in the javascript dir'
  def css_files
    files = files_in 'stylesheets', '**', '*'
    files.delete_if {|file| File.directory? file }
    files.delete_if {|file| file =~ /css$/}
    files.each do |file|
      say_status 'bad css', file, :red
    end
  end

  desc 'size', 'Checks the total size of the repo'
  def size
    maxsize = 5 * (1024*1024)
    if files_in("**","*").inject(0) {|sum,f| sum + File.size(f)} > maxsize
      say_status :fail, 'Theme is greater then max of 5mb', :red
    else
      say_status :good, 'Theme is smaller then 5mb'
    end
  end

  desc 'case_sensitive', 'Checks for files with capitol letters since they can cause problems'
  def case_sensitive
    files_in('**', '*[A-Z]*').each do |file|
      next if file =~ %r[/views/]
      next if file =~ %r[/test_data/]
      next if file =~ /README.md$/
      say_status 'bad case', file, :red
    end
  end

  desc 'yield_page', 'Checks that the layouts include the yield_page directive'
  def yield_page
    ['application.html', 'franchise.html', 'store.html', 'login.html'].each do |page|
      page = file_path 'layouts', page
      unless File.exists? page
        say_status :missing, page, :red
        next
      end

      open(page) do |f|
        found = f.readlines.grep(/yield_page/)
        case found.size
          when 0 then
            say_status 'no yield_page', page, :red
          when 1 then
            nil
          else
            say_status 'many yield_page', page, :red
        end
      end
    end
  end

  desc 'no_yield_page', 'Checks that the layouts exclude the yield_page directive'
  def no_yield_page
    ['index.html', 'franchise_index.html'].each do |page|
      page = file_path 'layouts', page
      unless File.exists? page
        say_status :missing, page, :red
        next
      end

      open(page) do |f|
        found = f.readlines.grep(/yield_page/)
        if found.size != 0
          say_status 'yield_path', page, :red
        end
      end
    end
  end

  desc 'yield_flash', 'Checks that yield flash is used'
  def yield_flash
    ['index.html', 'franchise_index.html','application.html', 'franchise.html', 'store.html', 'login.html'].each do |page|
      page = file_path 'layouts', page
      unless File.exists? page
        say_status :missing, page, :red
        next
      end

      open(page) do |f|
        found = f.readlines.grep(/yield_flash/)
        if found.size != 1
          say_status 'no yield_flash', page, :red
        end
      end
    end
  end

  desc 'no title', 'Checks that there is no title tag'
  def no_title
    Dir[file_path('layouts', '*')].each do |page|
      open(page) do |f|
        found = f.readlines.grep(%r(\<title\>))
        if found.size == 1
          say_status 'title', page, :red
        end
      end
    end
  end

  desc 'no_franchise', 'Checks that the store link doesn\'t exist on corporate pages'
  def no_corporate_store_link
    ['index.html','application.html','login.html'].each do |page|
      page = file_path 'layouts', page
      next unless File.exists? page

      open(page) do |f|
        found = f.readlines.grep(/store_link/)
        unless found.empty?
          say_status :store_link_found, page, :red
        end
      end
    end
  end

  desc 'all', 'Run all checks'
  def all
    say "Checking theme #{dir}"
    invoke :size

    invoke :admin_logo
    invoke :favicon
    invoke :unused_images
    invoke :image_files

    invoke :javascript_files
    invoke :no_jquery

    invoke :css_files

    invoke :case_sensitive
    invoke :yield_page
    invoke :yield_flash
    invoke :no_title
    invoke :no_corporate_store_link
  end
  default_task :all
end