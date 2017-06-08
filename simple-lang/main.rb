require_relative './syntax.rb'
require 'pp'

s = Simple

=begin
str = 'hello'
if (42 < 23 + (x - y))
  a = 'shit'
else
  a = 'world'
end 
p str + ',' + a + '!'
=end

exp = s.sequence(
  s.sequence(
    s.define(:str, s.string('hello')),
    s.if(
      s.lessThan(
        s.number(42),
        s.add(
          s.number(23),
          s.sub(
            s.variable(:x), 
            s.variable(:y)
          )
        )
      ),
      s.define(:a, s.string('shit')), 
      s.define(:a, s.string('world'))
    )
    
  ),
  
  s.funCall(:p, 
    s.add(
      s.add(
        s.add(
          s.variable(:str),
          s.string(',')
        ), 
        s.variable(:a)
      ), 
      s.string('!')
    )
  )
)

class Proc
  def inspect
    "«Proc:#{self}»"
  end

  def to_s
    self.object_id.to_s
  end
end

environment = {
  x: s.number(12),
  y: s.number(4),
  p: lambda{|*params| p *params; s.nothing },
  puts: lambda{|*params| puts *params; s.nothing },
}

machine = s.machine(exp, environment)

machine.run()