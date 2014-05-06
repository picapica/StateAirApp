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
  app.identifier = 'com.liulantao.stateair'

  app.version = '1.0.0'
  app.deployment_target = '6.0'
  app.device_family = [:iphone]
  app.interface_orientations = [:portrait]

  app.frameworks << "iAD"

  app.icons = ["StateAir-LOGO-100.png", "StateAir-LOGO-1024.png", "StateAir-LOGO-120.png", "StateAir-LOGO-128.png", "StateAir-LOGO-25.png", "StateAir-LOGO-256.png", "StateAir-LOGO-32.png", "StateAir-LOGO-50.png", "StateAir-LOGO-57.png", "StateAir-LOGO-512.png", "StateAir-LOGO-75.png"]

  app.development do
    app.provisioning_profile = "Development.mobileprovision"
  end

  app.release do
    app.provisioning_profile = "AppStore.mobileprovision"
  end
end
