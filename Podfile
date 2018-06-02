# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Simple Ingredient' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Simple Ingredient
  pod 'ObjectMapper', '~> 3.1'
  pod 'Alamofire', '~> 4.7'
  pod 'AlamofireImage', '~> 3.3'
  pod 'SDWebImage', '~> 4.0'

  target 'Simple IngredientTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Simple IngredientUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  # example to ignore all warnings from all pods
  inhibit_all_warnings!

  # example to ignore warnings from a specific pod
  pod 'Alamofire', :inhibit_warnings => true 
  pod 'ObjectMapper', :inhibit_warnings => true


end
