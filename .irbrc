require 'rubygems'

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError
end

begin
  require "hirb"
  Hirb.enable
rescue LoadError
end


IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200


if ENV['RAILS_ENV']
  require 'logger'
  logger = Logger.new(STDOUT)
  RAILS_DEFAULT_LOGGER = logger
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
