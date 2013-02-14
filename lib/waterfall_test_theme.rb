class WaterfallTestTheme < Base
  desc 'all', 'Executives all commands (default)'
  def all
    invoke 'check:all'
    invoke 'render:all'
  end
  default_task :all

  desc 'check', 'Checks all theme behaviors'
  def check
    invoke 'check:all'
  end

  desc 'render', 'Renders all layouts into views'
  def render
    invoke 'render:all'
  end
end