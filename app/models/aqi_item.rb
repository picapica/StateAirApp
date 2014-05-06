class AQIItem
  PROPERTIES = [:city, :timestamp, :title, :conc, :aqi, :aqi_level, :desc]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  @@all = {}
  @@latest_ts = {}

  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def color
    case self.aqi_level
    when "aqi_1"
      UIColor.greenColor
    when "aqi_2"
      UIColor.yellowColor
    when "aqi_3"
      UIColor.orangeColor
    when "aqi_4"
      UIColor.redColor
    when "aqi_5"
      UIColor.purpleColor
    when "aqi_6"
      UIColor.brownColor
    when "aqi_7"
      UIColor.darkGrayColor
    else
      UIColor.blueColor
    end
  end

  def color2
    case self.aqi_level
    when "aqi_1"
      UIColor.greenColor
    when "aqi_2"
      UIColor.whiteColor
    when "aqi_3"
      UIColor.yellowColor
    when "aqi_4"
      UIColor.orangeColor
    when "aqi_5"
      UIColor.redColor
    when "aqi_6"
      UIColor.purpleColor
    when "aqi_7"
      UIColor.brownColor
    else
      UIColor.blueColor
    end
  end

  def self.latest(city = "beijing")
    return nil unless @@all[city]
    @@all[city][@@latest_ts[city]]
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

              if @@latest_ts[item['city']].nil? or item['timestamp'] > @@latest_ts[item['city']]
                @@latest_ts[item['city']] = item['timestamp']
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
