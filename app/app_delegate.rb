class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    @storyboard = UIStoryboard.storyboardWithName("StateAir", bundle:nil)

    @cities_nav_VC = @storyboard.instantiateViewControllerWithIdentifier("cities_nav_VC")

    @cities_VC = @cities_nav_VC.viewControllers[0]
    @cities_VC.cities = City.all
    @cities_VC.aqi_items = []

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.rootViewController = @cities_nav_VC

    true
  end
end
