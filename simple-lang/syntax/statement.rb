require_relative './base_node'
require_relative './base_type'

class DoNothing < BaseNode
  def initialize
    @reducible = false
  end

  def ==(other)
    other.instance_of?(DoNothing)
  end

  def to_s
    'do-nothing'
  end
end

class Define < BaseNode

  attr_accessor :name
  attr_accessor :expression

  def initialize(name, expression)
    @name = name
    @expression = expression
    @reducible = true
  end

  def to_s
    "#{name} = #{expression}"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if expression.reducible?
      [Define.new(name, expression.reduce(environment)), environment]
    else
      [DoNothing.new, environment.merge(name => expression)]
    end
  end

end

class Sequence < BaseNode

  attr_accessor :first
  attr_accessor :last

  def initialize(first, last)
    @first = first
    @last = last
    @reducible = true
  end

  def to_s
    "#{first}; #{last}"
  end

  def reduce(environment)
    case first
    when DoNothing.new
      [last, environment]
    else
      reduce_first, reduce_env = first.reduce(environment)
      [Sequence.new(reduce_first, last), reduce_env]
    end
  end
end

class If < BaseNode
  
    attr_accessor :condition
    attr_accessor :consequence
    attr_accessor :alternative

  def initialize(condition, consequence, alternative)
    @condition = condition
    @consequence = consequence
    @alternative = alternative
    @reducible = true
  end

  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def reduce(environment)
   
    if condition.reducible?
      [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition.value
      when true
        [consequence, environment]
      when false
        [alternative, environment]
      end
    end
  end
end

class While < BaseNode

  attr_accessor :condition
  attr_accessor :body

  def initialize(condition, body)
    @condition = condition
    @body = body
    @reducible = true
  end

  def to_s
    "while (#{condition}) { #{body} }"
  end

  def reduce(environment)
    [If.new(condition, Sequence.new(body, self), DoNothing.new), environment]
  end

end

class FunCall < BaseNode

  attr_accessor :name
  attr_accessor :params

  def initialize(name, *params)
    @name = name
    @params = params
    @reducible = true
  end

  def to_s
    paramStr =  params.to_s
    "#{name}( #{paramStr.slice(1, paramStr.length - 2)})"
  end

  def reduce(environment)
    params.each_index do |index|
      if params[index].reducible?
        params[index] = params[index].reduce(environment)
        return FunCall.new(name, *params) 
      end
    end
    if environment[name].class == Proc
      environment[name][*params]
    else
      #TODO: 待实现
    end
  end

end

#TODO:  待实现
class Function < BaseNode

  attr_accessor :name
  attr_accessor :params
  
  def initialize(name, *params)
    @name = name
    @params = params
    @reducible = true
  end

  def to_s
    "#{name}(#{params})"
  end

  def ==(other)
    other.instance_of?(Function) && other.name == name && other.params = params
  end

  def reduce(environment)
  end

end