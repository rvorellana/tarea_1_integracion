class HomepagesController < ApplicationController
  def home
    response = RestClient.get('https://tarea-1-breaking-bad.herokuapp.com/api/characters/1')
    results = JSON.parse(response.to_str)
    @name = results[0]["name"]
  end
end
