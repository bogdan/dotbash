require 'rubygems'

require 'logger'
require "net/http"

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


if defined?(IRB)
  IRB.conf[:AUTO_INDENT] = true
  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:EVAL_HISTORY] = 200
end


logger = Logger.new(STDOUT)

silence_warnings do
  RAILS_DEFAULT_LOGGER = logger
end

if ENV['RAILS_ENV'] && defined?(IRB)
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

if defined?(ActiveRecord) && ActiveRecord::Base.respond_to?(:logger=)
  ActiveRecord::Base.logger = Rails.logger
end

if Net::HTTP.respond_to?(:logger=)
  Net::HTTP.logger = RAILS_DEFAULT_LOGGER
end
