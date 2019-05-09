require 'csv'
require_relative '../models/recipe'

class Cookbook
  def initialize(csv_path)
    @csv_path = csv_path
    @recipes = load_csv(csv_path)
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    CSV.open(@csv_path, 'a') do |csv|
      csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done_str, recipe.difficulty]
    end
  end

  def find_recipe(recepie)
    @recepies.select { |rec| rec.name == recepie }
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save
  end

  def mark_recipe_as_done_at(idx)
    @recipes[idx].done_str = "1"
    save
  end

  private

  def load_csv(csv_path)
    ary = []
    CSV.foreach(csv_path) do |row|
      ary << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
    return ary
  end

  def save
    CSV.open(@csv_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done_str, recipe.difficulty]
      end
    end
  end
end
