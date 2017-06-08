require './syntax/base_node'
require './syntax/base_type'

class Add < BaseNode

  attr_accessor :left
  attr_accessor :right

  def initialize(left, right)
    @left = left
    @right = right
    @reducible = true
  end

  def to_s
    "(#{left} + #{right})"
  end

  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      if left.class == Str
        if right.class == Str
          Str.new(left.value + right.value)
        else
          p 'type error!'
          exit
        end
      else
        Number.new(left.value + right.value)
      end
    end
  end

end

class Sub < BaseNode

  attr_accessor :left
  attr_accessor :right

  def initialize(left, right)
    @left = left
    @right = right
    @reducible = true
  end

  def to_s
    "(#{left} - #{right})"
  end

  def reduce(environment)
    if left.reducible?
      Sub.new(left.reduce(environment), right)
    elsif right.reducible?
      Sub.new(left, right.reduce(environment))
    else
      Number.new(left.value - right.value)
    end
  end

end

class Multiply < BaseNode

  attr_accessor :left
  attr_accessor :right

  def initialize(left, right)
    @left = left
    @right = right
    @reducible = true
  end

  def to_s
    "#({left} * #{right})"
  end

  def reduce(environment)
    if left.reducible?
      Multiply.new(left.reduce(environment), right)
    elsif right.reducible?
      Multiply.new(left, right.reduce(environment))
    else
      Number.new(left.value * right.value)
    end
  end

end

class Except < BaseNode

  attr_accessor :left
  attr_accessor :right

  def initialize(left, right)
    @left = left
    @right = right
    @reducible = true
  end

  def to_s
    "(#{left} / #{right})"
  end

  def reduce(environment)
    if left.reducible?
      Except.new(left.reduce(environment), right)
    elsif right.reducible?
      Except.new(left, right.reduce(environment))
    else
      Number.new(left.value / right.value)
    end
  end

end

class Equal < BaseNode

  attr_accessor :left
  attr_accessor :right

  def initialize(left, right)
    @left = left
    @right = right
    @reducible = true
  end

  def to_s
    "(#{left} == #{right})"
  end

  def reduce(environment)
    if left.reducible?
      Equal.new(left.reduce(environment), right)
    elsif right.reducible?
      Equal.new(left, right.reduce(environment))
    else
      Boolean.new(left.value == right.value)
    end
  end

end

class LessThan < BaseNode

  attr_accessor :left
  attr_accessor :right

  def initialize(left, right)
    @left = left
    @right = right
    @reducible = true
  end

  def to_s
    "(#{left} < #{right})"
  end

  def reduce(environment)
    if left.reducible?
      LessThan.new(left.reduce(environment), right)
    elsif right.reducible?
      LessThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value < right.value)
    end
  end

end

class GreaterThan < BaseNode

  attr_accessor :left
  attr_accessor :right

  def initialize(left, right)
    @left = left
    @right = right
    @reducible = true
  end

  def to_s
    "(#{left} > #{right})"
  end

  def reduce(environment)
    if left.reducible?
      GreaterThan.new(left.reduce(environment), right)
    elsif right.reducible?
      GreaterThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value > right.value)
    end
  end

end