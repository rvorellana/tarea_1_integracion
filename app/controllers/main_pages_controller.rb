class MainPagesController < ApplicationController
  def home
    response = RestClient.get('https://tarea-1-breaking-bad.herokuapp.com/api/episodes')
    episodes = JSON.parse(response.to_str)
    series = ["Breaking Bad", "Better Call Saul"]
    @serie_info = {}
    
    series.each do |serie|
      @serie_info[serie] = {}
      #Tengo una lista para la season de cada episodio
      seasons_episodes = []
      # Tengo un hash para todos los episodios de esa season
      seasons = episodes.select do |hash|
        hash["series"] == serie
      end

      # Para cada episodio agrego su season como elemento a la lista de seasons de episodios
      seasons.each do |episode|
        seasons_episodes << episode["season"].to_i
      end

      # Saco la lista de seasons sin repetir
      seasons_unique = seasons_episodes.uniq.sort
      # Creo el has a enviar a la página
      seasons_unique.each do |season|
        episodes_seasons = seasons_episodes.select do |elem|
          elem == season
        end
        @serie_info[serie][season] = episodes_seasons.length
      end
    end
  end

  def episodes
    @serie = params[:serie]
    @season = params[:season]
    @season_info = {}
    response = RestClient.get("https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=#{@serie}")
    episodes = JSON.parse(response.to_str)
    episodes_season = episodes.select do |hash|
      hash["season"] == @season
    end
    episodes_season.each do |episode|
      @season_info[episode["episode"]] = {episode_id: episode["episode_id"], title: episode["title"]}
    end
  end

  def episode
    episode = params[:id]
    response = RestClient.get("https://tarea-1-breaking-bad.herokuapp.com/api/episodes/#{episode}")
    @episode_info = JSON.parse(response.to_str)[0]
    @serie = @episode_info["series"]
    @season = @episode_info["season"]
    puts(@serie)
    puts(@season)
    puts("HOLAA")
    #Segundo Request
    @season_info = {}
    response = RestClient.get("https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=#{@serie}")
    episodes = JSON.parse(response.to_str)
    
    episodes_season = episodes.select do |hash|
      hash["season"] == @season
    end
    episodes_season.each do |episode|
      @season_info[episode["episode"]] = {episode_id: episode["episode_id"], title: episode["title"]}
    end
  end


  def character
    @character = params[:name]
    response = RestClient.get("https://tarea-1-breaking-bad.herokuapp.com/api/characters?name=#{@character}")
    @character_info = JSON.parse(response.to_str)[0]
    response = RestClient.get("https://tarea-1-breaking-bad.herokuapp.com/api/quote?author=#{@character}")
    @quotes = JSON.parse(response.to_str)
  end

end
