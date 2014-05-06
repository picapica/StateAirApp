# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'StateAir'
  app.identifier = 'com.liulantao.StateAire'

  app.version = '1.0'
  app.deployment_target = '6.0'
  app.device_family = [:iphone]
  app.interface_orientations = [:portrait]

  app.frameworks << "iAD"

  app.icons = ["icons/temperature-100.png", "icons/temperature-128.png", "icons/temperature-25.png", "icons/temperature-256.png", "icons/temperature-32.png", "icons/temperature-50.png", "icons/temperature-512.png", "icons/temperature-75.png"]

  app.development do
    app.provisioning_profile = "Development.mobileprovision"
  end

  app.release do
    app.provisioning_profile = "AppStore.mobileprovision"
  end
end
