
begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end


if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
#Pry.plugins["doc"].activate!

#::IRB = ::Pry
load File.dirname(__FILE__) + "/.irbrc"


rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails
  
  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  else
    require 'rails/console/app'
    require 'rails/console/helpers'
    extend Rails::ConsoleMethods
  end
end

Pry::Commands.command(/^$/, "repeat last command") do
  _pry_.run_command Pry.history.to_a.last  
end  

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end
