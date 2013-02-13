class WaterfallTestTheme < Base
  desc 'all', 'Executives all commands (default)'
  def all
    invoke 'check:all'
    invoke 'render:all'
  end
  default_task :all
end