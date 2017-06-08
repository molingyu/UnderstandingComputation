require_relative './base_node'

class Number < BaseNode

  attr_accessor :value

  def initialize(value)
    @value = value
    @reducible = false
  end

  def to_s
    @value.to_s
  end

  def ==(other)
    other.instance_of?(Number) && other.value == value
  end

end

class Boolean < BaseNode

  attr_accessor :value

  def initialize(value)
    @value = value
    @reducible = false
  end

  def to_s
    @value.to_s
  end

  def ==(other)
    other.instance_of?(Boolean) && other.value == value
  end

end

class Str < BaseNode

  attr_accessor :value

  def initialize(value)
    @value = value
    @reducible = false
  end

  def to_s
    "\"#{value}\""
  end

  def ==(other)
    other.instance_of?(Str) && other.value == value
  end

end

class Variable < BaseNode

  attr_accessor :name

  def initialize(name)
    @name = name
    @reducible = true
  end

  def to_s
    @name.to_s
  end

  def reduce(environment)
    environment[name]
  end

  def ==(other)
    other.instance_of?(Variable) && other.name == name
  end

end