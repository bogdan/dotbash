class Object
  def ri
    raise inspect
  end

  def pi
    puts inspect
    self
  end
end

def dbg(trace = nil)
  if !trace || caller_include?(trace)
    require 'debug'
    debugger
  end
end

def caller_include?(trace)
  caller.join("|").include?(trace)
end

