class CitiesViewController < UITableViewController
  CELL_ID = "CITY_ITEM"
  attr_accessor :cities, :aqi_items

  def viewDidLoad
    view.dataSource = view.delegate = self

    self.title = "cities"._

    refreshControl = UIRefreshControl.new
    refreshControl.addTarget(self, action:"pull_refresh", forControlEvents:UIControlEventValueChanged)

    self.refreshControl = refreshControl
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @cities.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID)

    city = @cities[indexPath.row]
    cell.cityLabel.text = city.name._

    if aqi_item = AQIItem.latest(city.name)
      @aqi_items[indexPath.row] = aqi_item

      cell.aqiLabel.text = aqi_item.aqi.to_s
      cell.descLabel.text = aqi_item.desc._

      cell.levelLabel.backgroundColor = aqi_item.color2
    else
      AQIItem.refresh(city.name) do
        aqi_item = AQIItem.latest(city.name)
        @aqi_items[indexPath.row] = aqi_item

        cell.aqiLabel.text = aqi_item.aqi.to_s if aqi_item.aqi
        cell.descLabel.text = aqi_item.desc._
        cell.levelLabel.backgroundColor = aqi_item.color2
      end
    end

    cell
  end

  def prepareForSegue(segue, sender:sender)
    if segue.identifier == 'ShowCityAir'
      @nav_VC = segue.destinationViewController
      @city_VC = @nav_VC.viewControllers[0]
      @city_VC.delegate = self

      indexPath = self.tableView.indexPathForSelectedRow
      @city_VC.city = @cities[indexPath.row]
      @city_VC.editing_index = indexPath.row
      @city_VC.aqi_item ||= @aqi_items[indexPath.row]
    end
  end

  def CityVCDidCancel(controller)
    self.dismissViewControllerAnimated(true, completion:nil)
    view.reloadData
  end

  def pull_refresh
    City.all.each do |city|
      AQIItem.refresh(city.name) do
        view.reloadData
      end
    end

    self.refreshControl.endRefreshing
  end
end
