class CityCell < UITableViewCell
    attr_accessor :city, :aqi_item
    attr_accessor :cityLabel, :aqiLabel, :descLabel, :levelLabel

    extend IB
    outlet :cityLabel, UILabel
    outlet :aqiLabel, UILabel
    outlet :descLabel, UILabel
    outlet :levelLabel, UILabel
end
