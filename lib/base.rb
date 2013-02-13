class Base < Thor
  class_option :dir, :type => :string, :default => '.'

  no_tasks do
    def file_path(*args)
      File.join(args.insert(0,dir))
    end

    def files_in(*args)
      Dir[file_path(*args)]
    end

    def dir
      options[:dir] || Dir.pwd
    end
  end
end