class MapScraper
  def scrape_map(race_id)
    race = db.load! race_id
    if race.runkeeper_url.present?
      html = HTTParty.get race.runkeeper_url
      race.map_points = html.scan(/"latitude":(\d+\.\d+),"longitude":(\d+\.\d+)/).map{|pair| [pair[0].to_f, pair[1].to_f]}
      db.save race
    end
  end
  
  private
  
  def db
    CouchPotato.database
  end
end