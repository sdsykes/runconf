class HoptoadErrorHandler
  def handle(ex)
    HoptoadNotifier.notify ex
  end
end

RUNKEEPER_MAP_QUEUE = GirlFriday::WorkQueue.new(:parse_runkeeper_maps, size: 2, error_handler: HoptoadErrorHandler) do |msg|
  MapScraper.new.scrape_map(msg[:race_id])
end