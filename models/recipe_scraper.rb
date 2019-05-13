require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

class RecipeScraper
  def self.get_recipes(ingredient)
    # ingredient is a string
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"
    raw_html = open(url).read
    html_doc = Nokogiri::HTML(raw_html)
    recipes = []
    html_doc.search(".m_contenu_resultat").take(10).each do |element|
      name = element.search(".m_titre_resultat").text.strip
      description = element.search(".m_texte_resultat").text.strip
      prep_time = element.search(".m_detail_time")[0].elements[0].text.strip
      difficulty = element.search(".m_detail_recette").text.strip.split(" - ")[2]
      #binding.pry
      recipe = Recipe.new(name, description, prep_time, "0", difficulty)
      recipes << recipe
    end
    return recipes

    # array of Recipe instances
  end
end
