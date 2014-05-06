class CitiesViewController < UITableViewController
  CELL_ID = "CITY_ITEM"
  attr_accessor :cities

  def viewDidLoad
    view.dataSource = view.delegate = self

    self.title = "cities"._
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @cities.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID)

    city = @cities[indexPath.row]
    cell.text = city.name._

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
    end
  end

  def CityVCDidCancel(controller)
    self.dismissViewControllerAnimated(true, completion:nil)
    view.reloadData
  end

end
