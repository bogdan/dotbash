
require "benchmark"

class Module
  def delegate_new(*methods)
    options = methods.pop
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, "Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, :to => :greeter)."
    end

    if options[:prefix] == true && to.to_s =~ /^[^a-z_]/
      raise ArgumentError, "Can only automatically set the delegation prefix when delegating to a method."
    end

    prefix = options[:prefix] ? "#{options[:prefix] == true ? to : options[:prefix]}_" : ''

    file, line = caller.first.split(':', 2)
    line = line.to_i

    methods.each do |method|
      method_name = prefix + method.to_s
      module_eval(<<-EOS, file, line - 1)
        def #{method_name}(*args, &block)
          ActiveSupport::Delegation.perform(self, #{to}, #{method.inspect}, #{method_name.inspect}, #{options[:allow_nil].inspect}, #{options[:to].inspect}, args, block)
        end
      EOS
    end
  end


  def delegate_old(*methods)
    options = methods.pop
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, "Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, :to => :greeter)."
    end

    if options[:prefix] == true && options[:to].to_s =~ /^[^a-z_]/
      raise ArgumentError, "Can only automatically set the delegation prefix when delegating to a method."
    end

    prefix = options[:prefix] ? "#{options[:prefix] == true ? to : options[:prefix]}_" : ''

    file, line = caller.first.split(':', 2)
    line = line.to_i

    methods.each do |method|
      on_nil =
        if options[:allow_nil]
          'return'
        else
          %(raise "#{self}##{prefix}#{method} delegated to #{to}.#{method}, but #{to} is nil: \#{self.inspect}")
        end

      module_eval(<<-EOS, file, line - 5)
        def #{prefix}#{method}(*args, &block)               # def customer_name(*args, &block)
      #{to}.__send__(#{method.inspect}, *args, &block)  #   client.__send__(:name, *args, &block)
        rescue NoMethodError                                # rescue NoMethodError
          if #{to}.nil?                                     #   if client.nil?
      #{on_nil}                                       #     return # depends on :allow_nil
          else                                              #   else
            raise                                           #     raise
          end                                               #   end
        end                                                 # end
      EOS
    end
  end

end

module ActiveSupport
  module Delegation #:nodoc:
    def self.perform(object, target, method, method_name, allow_nil, to, args, block)
      target.__send__(method, *args, &block)
    rescue NoMethodError
      if target.nil?
        return nil if allow_nil
        raise "#{object.class}##{method_name} delegated to #{to}.#{method}, but #{to} is nil: #{object.inspect}"
      else
        raise
      end
    end
  end
end


AMOUNT = 1000
class A
  AMOUNT.times do |i|
    define_method("hello#{i}") do
      nil
    end
  end
end
class Old
  def initialize
    @a = A.new
  end
end

class New
  def initialize
    @a = A.new
  end
end

Benchmark.bmbm do |x|
  x.report do
    AMOUNT.times do |i|
      Old.delegate_old "hello#{i}", :to => "@a"
    end
  end
  x.report do
    AMOUNT.times do |i|
      New.delegate_new "hello#{i}", :to => "@a"
    end
  end
end

o = Old.new
n = New.new


Benchmark.bmbm do |x|
  x.report do
    AMOUNT.times do |i|
      o.send("hello#{i}")
    end
  end
  x.report do
    AMOUNT.times do |i|
      n.send("hello#{i}")
    end
  end
end
