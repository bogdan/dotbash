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

begin
  require "hirb"
  Hirb.enable
rescue LoadError
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
  return out
ensure
  $stdout = STDOUT
end
