class Recipe
  attr_reader :name, :description, :prep_time, :difficulty
  attr_accessor :done_str

  def initialize(name, description, prep_time, done_str, difficulty)
    @name = name
    @description = description
    @prep_time = prep_time
    @done_str = done_str
    @difficulty = difficulty
  end
end
