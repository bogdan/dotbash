require "benchmark"

AMOUNT = 10000
Benchmark.bmbm do |x|
  x.report do
      class B
    AMOUNT.times do |i|
      class_eval <<-E
      def hello#{i}(*args)
          args + [#{i}]
      end
      E

      end
      
    end
  end
  x.report do
    class A
      AMOUNT.times do |i|
        define_method(:"hello#{i}") do |*args|
          args + [i]
        end
      end
    end
  end
end


a = A.new
b = B.new
Benchmark.bmbm do |x|
  x.report do
    AMOUNT.times do |i|
      b.send(:"hello#{i}")
    end
  end
  x.report do
    AMOUNT.times do |i|
      a.send(:"hello#{i}")
    end
  end
end
