require 'rubygems'

require 'logger'
require "net/http"
begin
  require 'active_support'
rescue LoadError
end

irb_conf = defined?(::IRB) && IRB.respond_to?(:conf)
load File.dirname(__FILE__) + "/.rubyrc/bogdan.rb"

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


logger_class = defined?(ActiveSupport) ? ActiveSupport::Logger : Logger
logger = logger_class.new(STDOUT)
logger.formatter = proc do |_, _, _, message|
  message + "\n"
end
if defined?(ActiveSupport)
  logger = ActiveSupport::TaggedLogging.new(logger)
end
STDLOGGER = logger

if ENV['RAILS_ENV'] && irb_conf
  IRB.conf[:PROMPT] ||= {}
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
  Rails.logger = STDLOGGER
end

def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end

def q(query)
  sql(query)
end

if defined?(HttpLogger)
  HttpLogger.logger = STDLOGGER
end

def watch(seconds = 1)
  loop do
    result = yield
    system('reset')
    puts result.to_s
    sleep(seconds)
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
  def ims
    case self.class
    when Class
      self.public_methods.sort - Object.public_methods
    when Module
      self.public_methods.sort - Module.public_methods
    else
      self.public_methods.sort - Object.new.public_methods
    end
  end

  def p
    puts self
  end

end



begin
  require 'hirb'
  HIRB_LOADED = true
rescue LoadError
  HIRB_LOADED = false
end


def loud_logger
  enable_hirb
  set_logger_to STDLOGGER
end

def init_ar
  return unless defined?(ActiveRecord)
  loud_logger
  ActiveRecord::Relation.class_eval do
    def top(*groups)
      relation = self
      limit = groups.last.is_a?(Integer) ? groups.pop : 30
      rez = relation.is_a?(ActiveRecord::Relation) ?
        relation.reorder("count_all desc").group(groups).limit(limit).count :
        relation.to_a.sort_by(&:last).reverse.take(limit)
      rez = rez.map do |key, value|
        [key, value].flatten
      end
      rez
    end
    def ttop(*args)
      tbl(top(*args))
    end

    def days(num = 30)
      where(created_at: num.days.ago..Time.now)
    end
  end
end

def quiet_logger
  disable_hirb
  set_logger_to nil
end

def set_logger_to(logger)
  return false unless defined?(ActiveRecord)
  Rails.logger = STDLOGGER
  ActiveRecord::Base.logger = logger
  ActiveRecord::Base.clear_reloadable_connections!
  true
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


def r
  reload!
end

def r!
  reload!
end

def ex
  ex = nil
  begin
    yield
  rescue => ex
  end
  ex
end

init_ar

class Integer
  def h
 ActiveSupport::NumberHelper.number_to_delimited(self, delimiter: '_')

  end
end

[Enumerable, Hash].each do |klass|
  klass.class_eval do

    def j(sep = ',')
      join(sep)
    end

    def cp
      compact
    end

    def mp(&block)
      mpfl(&block)
    end

    def ea(&block)
      call_support_method(:each, &block)
      self
    end

    def mpp(&block)
      call_support_method(:map, &block)
    end

    def mt(&block)
      mpp(&block).t
    end

    def mpt(&block)
      mt(&block)
    end

    def sl(&block)
      call_support_method(:select, &block)
    end

    def si(arg = nil)
      select do |el|
        el.include?(arg)
      end
    end

    def ri(arg = nil)
      reject do |el|
        el.include?(el)
      end
    end

    def rj(&block)
      call_support_method(:reject, &block)
    end

    def fl
      flatten
    end

    def mpfl(&block)
      mpp(&block).flatten
    end

    def sb(&block)
      call_support_method(:sort_by, &block)
    end

    def rv
      reverse
    end

    def f(&block)
      call_support_method(:find, &block)
    end

    def call_support_method(method, &block)
      send(method) do |object|
        object.instance_eval(&block) if block
      end
    end

    def tk(*args, &block)
      take(*args, &block)
    end

    def u(&block)
      call_support_method(:uniq, &block)
    end

    def pr(&block)
      call_support_method(:partition, &block)
    end

    def y
      puts to_yaml
    end

    def j
      puts JSON.pretty_generate(self)
    end

    def t
      Object.send(:tbl, self)
    end

  end
end

def tbl(rows, options = {})
  require "hirb"
  rows = rows.to_a
  unless rows.first.is_a?(Array) || rows.first.is_a?(Hash)
    rows = rows.map {|data| [data]}
  end
  puts Hirb::Helpers::Table.render(rows, options)
  nil
end

def json(data)
  puts JSON.pretty_generate(data)
end


def cl
  ActiveRecord::Base.clear_active_connections!
  true
end

def pl
  wt do
    data = User.connection.select_all("show full processlist")
    data = data.select {|z| z["Command"] != "Sleep"}.map do |z|
      z.except("Command", "Host", "State", "User", "db")
    end
    tbl data
  end
end

def wt(interval = 1)
  loop do
    system("clear")
    data = yield
    puts data if data
    sleep interval
  end
end

def get(url)
  url = url.strip
  Rails.cache.instance_variable_get("@data").client.logger = STDLOGGER
  if Rails.respond_to?(:persistent_cache)
    Rails.cattr_reader :persistent_cache do
      # Removing the pool
      ActiveSupport::Cache::RedisStore.new(
        RedisPool::CONFIG[:persistent_cache],
        expires_in: 1.day,
      )
    end

    Rails.persistent_cache.instance_variable_get("@data").client.logger = STDLOGGER
  end
  [ActionView::Base, ActionController::Base, ActiveRecord::Base].each do |object|
    object.logger = STDLOGGER
  end

  ApplicationController.perform_caching = true

  ApplicationController.class_eval do
    def current_user
      @cu||= User.find_by_email('bogdan@talkable.com')
    end
  end

  origin = DOMAIN_SETTINGS[:default]
  app.get(Furi.defaults(url, origin))
end
