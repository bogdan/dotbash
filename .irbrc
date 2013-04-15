require 'rubygems'

require 'logger'
require "net/http"

if defined?(Ripl)
  [
    "ripl/color_error",
    "ripl/color_streams",
    "ripl/color_result",
  ].each do |plugin|
    begin
      require plugin
    rescue LoadError
    end
  end
end

irb_conf = defined?(IRB) && IRB.respond_to?(:conf)

if irb_conf
  begin
    require 'wirble'
    Wirble.init
    Wirble.colorize
  rescue LoadError
  end
end


if irb_conf
  IRB.conf[:AUTO_INDENT] = true
  IRB.conf[:SAVE_HISTORY] = 1000000
  IRB.conf[:EVAL_HISTORY] = 200
end


logger = Logger.new(STDOUT)

if self.respond_to?(:silence_warnings)
  silence_warnings do
    RAILS_DEFAULT_LOGGER = logger
  end
else
  RAILS_DEFAULT_LOGGER = logger
end

if ENV['RAILS_ENV'] && irb_conf
  IRB.conf[:PROMPT][:CUSTOM] = {
    :PROMPT_N => "#{ENV["RAILS_ENV"]} >> ",
    :PROMPT_I => "#{ENV["RAILS_ENV"]} >> ",
    :PROMPT_S => nil,
    :PROMPT_C => "?> ",
    :RETURN => "=> %s\n"
  }

  IRB.conf[:PROMPT_MODE] = :CUSTOM


  IRB.conf[:HISTORY_FILE] = "./tmp/irb_history"
end

if defined?(Rails) && Rails.respond_to?(:logger=)
  Rails.logger = RAILS_DEFAULT_LOGGER
end

if defined?(ActiveRecord) 
  if ActiveRecord::Base.respond_to?(:logger=)
    ActiveRecord::Base.logger = Rails.logger
  end
end
def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end

if Net::HTTP.respond_to?(:logger=)
  Net::HTTP.logger = RAILS_DEFAULT_LOGGER
end

def watch(seconds = 1)
  loop do
    result = yield
    system('reset')
    puts result.to_s
    sleep(2)
  end
end

def capture_stdout
  out = StringIO.new
  $stdout = out
  yield
  return out.string
ensure
  $stdout = ::STDOUT
end


class Object
  def interesting_methods
    case self.class
    when Class
      self.public_methods.sort - Object.public_methods
    when Module
      self.public_methods.sort - Module.public_methods
    else
      self.public_methods.sort - Object.new.public_methods
    end
  end
end



begin
  require 'hirb'
  HIRB_LOADED = true
rescue LoadError
  HIRB_LOADED = false
end

require 'logger'

def loud_logger
  enable_hirb
  set_logger_to Logger.new(STDOUT)
end

def quiet_logger
  disable_hirb
  set_logger_to nil
end

def set_logger_to(logger)
  if defined?(ActiveRecord)
    ActiveRecord::Base.logger = logger
    ActiveRecord::Base.clear_reloadable_connections!
  end
end

def enable_hirb
  if HIRB_LOADED
    Hirb::Formatter.dynamic_config['ActiveRecord::Base']
    Hirb.enable
  else
    puts "hirb is not loaded"
  end
end

def disable_hirb
  if HIRB_LOADED
    Hirb.disable
  else
    puts "hirb is not loaded"
  end
end


def r!
  reload!
end

loud_logger

class Array
  class Recorder


    (instance_methods + private_instance_methods).each do |method|
      unless method.to_s =~ /^(__|instance_eval|instance_exec)/
        undef_method method
      end
    end

    def self.run(&block)
      new(&block)._commands
    end


    def initialize(&block)
      instance_eval(&block)
    end

    def _commands
      @_commands ||= []
    end
    def method_missing(meth, *args, &blk)
      _commands  << meth.to_sym
      self
    end
  end
  def mp(&block)
    apply_recorder(:map, &block)
  end

  def sl(&block)
    apply_recorder(:select, &block)
  end

  def apply_recorder(method, &block)
    commands = Recorder.run(&block)
    result = self
    commands.each do |command|
      result = result.send(method, &command)
    end
    result
  end
end

