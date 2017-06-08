class BaseNode

  class << self
    def add(name)
      @@table = [] if @@table
      @@table.push(name)
      attr_accessor(name)
    end
  end

  def inspect
    "«#{self}»"
  end

  def to_s; end

  def ==(other_node)
  end

  def reducible?
    @reducible
  end

  def reduce(environment)
  end

end