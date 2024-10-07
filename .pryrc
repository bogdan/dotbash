# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
#Pry.plugins["doc"].activate!

#::IRB = ::Pry
load File.dirname(__FILE__) + "/.irbrc"


rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  require 'rails/console/methods'
  extend Rails::ConsoleMethods
  include Rails::ConsoleMethods
  init_ar
end


if defined?(Pry::Byebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'b', 'break'
  Pry::Commands.command(/^$/, "repeat last command") do
    _pry_.input = StringIO.new(Pry.history.to_a.last)
  end
end
