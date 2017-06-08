class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, env = statement.reduce(environment)
    self.environment = env if env != nil
  end

  def run
    while statement.reducible?
      puts "exp: #{statement}", "env: #{environment}", ''
      step
    end
    puts "exp: #{statement}", "env: #{environment}\n", ''
  end
end