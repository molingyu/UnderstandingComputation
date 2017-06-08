require './syntax/base_type'
require './syntax/arithmetic'
require './syntax/statement'
require './syntax/machine'

module Simple
  class << self
    def number(name)
      Number.new(name)
    end

    def boolean(value)
      Boolean.new(value)
    end

    def string(value)
      Str.new(value)
    end

    def funCall(name, *params)
      FunCall.new(name, *params)
    end

    def variable(value)
      Variable.new(value)
    end

    def add(left, right)
      Add.new(left, right)
    end

    def sub(left, right)
      Sub.new(left, right)
    end

    def multiply(left, right)
      Multiply.new(left, right)
    end

    def except(left, right)
      Except.new(left, right)
    end

    def equal(left, right)
      Equal.new(left, right)
    end

    def lessThan(left, right)
      LessThan.new(left, right)
    end

    def greaterThan(left, right)
      GreaterThan.new(left, right)
    end

    def define(name, statement)
      Define.new(name, statement)
    end

    def sequence(first, last)
      Sequence.new(first, last)
    end

    def if(condition, consequence, alternative)
      If.new(condition, consequence, alternative)
    end

    def while(condition, statement)
      While.new(condition, statement)
    end

    def nothing
      DoNothing.new
    end

    def machine(expression, statement)
      Machine.new(expression, statement)
    end
  end
end