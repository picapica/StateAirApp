class AQIItem
  PROPERTIES = [:city, :timestamp, :title, :conc, :aqi, :desc]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  @@all = {}
  @@latest = {}

  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def self.latest(city = "beijing")
    @@all[city][@@latest[city]]
  end

  def self.refresh(city = "beijing", &block)
    url = "http://air.mkmd.cn/aqi/%s.json" % [city]
    AFMotion::JSON.get(url) do |result|
      if result and result.object
        if status = result.object['status'] and msg = result.object['msg']
          result.object['data'].each do |item|
            @@all[item['city']] ||= {}
            unless @@all[item['city']][item['timestamp']]
              @@all[item['city']][item['timestamp']] = AQIItem.new(item)

              if @@latest[item['city']].nil? or item['timestamp'] > @@latest[item['city']]
                @@latest[item['city']] = item['timestamp']
              end
            end
          end

          block.call
        end
      else
      end
    end
  end
end