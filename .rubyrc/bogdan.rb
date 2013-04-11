def ri(object)
  raise object.inspect
end

def dbg(trace = nil)
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("1.9.3")
    require "debugger"
  else
    require 'ruby-debug'
  end
  if !trace || caller_include?(trace) 
    debugger
  end
end

def caller_include?(trace)
  caller.join("|").include?(trace)
end

