class CityViewController < UIViewController
  attr_accessor :delegate, :city, :aqi_item, :editing_index

  include BW::KVO

  extend IB
  outlet :cityLabel, UILabel
  outlet :titleLabel, UILabel
  outlet :aqiLabel, UILabel
  outlet :descLabel, UILabel
  outlet :abbanner, ADBannerView

  def viewDidLoad
    super

    self.title = self.city.name

    ["city", "title", "aqi", "desc"].each do |prop|
      observe(self.aqi_item, prop) do |old_value, new_value|
        instance_variable_get("@#{prop}Label").text = "#{new_value}"
      end
    end

    AQIItem.refresh(self.city.name) do
      self.aqi_item = AQIItem.latest(@city.name)
      ["city", "title", "aqi", "desc"].each do |prop|
        instance_variable_get("@#{prop}Label").text = "#{self.aqi_item.send(prop)}"
      end
    end
  end

  def init
    super

    self
  end

  def viewWillAppear(animated)
    super
  end

  def refreshView
  end

  def cancel(sender)
    @delegate.CityVCDidCancel(self)
  end
end
