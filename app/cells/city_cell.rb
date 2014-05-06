class CityCell < UITableViewCell
    attr_accessor :city, :aqi_item
    attr_accessor :cityLabel, :aqiLabel, :descLabel

    extend IB
    outlet :cityLabel, UILabel
    outlet :aqiLabel, UILabel
    outlet :descLabel, UILabel
end
