class City
  @@cities = ["beijing", "chengdu", "guangzhou", "shanghai", "shenyang"]
  @@all = nil

  PROPERTIES = [:name]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def self.all
    @@all ||= @@cities.map { |name|
      City.new(:name => name)
    }
  end
end
