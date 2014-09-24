class CityViewController < UIViewController
  attr_accessor :delegate, :city, :aqi_item, :editing_index

  include BW::KVO

  extend IB
  outlet :cityLabel, UILabel
  outlet :titleLabel, UILabel
  outlet :aqiLabel, UILabel
  outlet :descLabel, UILabel
  outlet :adbanner, ADBannerView

  def viewDidLoad
    super

    self.title = self.city.name._

    if self.aqi_item
      #@cityLabel.text = self.aqi_item.city._
      @titleLabel.text = self.aqi_item.title._
      @aqiLabel.text = self.aqi_item.aqi._
      @descLabel.text = self.aqi_item.desc._
    end

    ["city", "title", "aqi", "desc"].each do |prop|
      observe(self.aqi_item, prop) do |old_value, new_value|
        instance_variable_get("@#{prop}Label").text = "#{new_value}"._
      end
    end

    #observe(self.aqi_item, "aqi_level") do |old_value, new_value|
    #  [@aqiLabel, @descLabel].each do |label|
    #    label.textColor = self.aqi_item.color
    #  end
    #end

    AQIItem.refresh(self.city.name) do
      self.aqi_item = AQIItem.latest(@city.name) if AQIItem.latest(@city.name)
      ["city", "title", "aqi", "desc"].each do |prop|
        instance_variable_get("@#{prop}Label").text = "#{self.aqi_item.send(prop)}"._
      end
      #[@aqiLabel, @descLabel].each do |label|
      #  label.textColor = self.aqi_item.color2
      #end
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
