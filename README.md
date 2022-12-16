# DeliveryApp(In progress)

## Demo

<img src = "https://user-images.githubusercontent.com/96892718/208172021-3b160797-655a-4237-805c-1dbebfd06b9a.png" height="500rm">  <img src ="https://user-images.githubusercontent.com/96892718/208172109-61347e09-7d84-4017-81f6-bb9351241716.png" height="500rm">  <img src ="https://user-images.githubusercontent.com/96892718/208172182-b40c7a1a-33ef-4bbb-b0a9-ae949e54951f.png" height="500rm"> <img src = "https://user-images.githubusercontent.com/96892718/208172295-6112f555-70b2-4bbd-9653-6f1e86a4ac42.png" height = "500rm">

## App working process

<img src = "https://user-images.githubusercontent.com/96892718/208172700-25b33d36-cb6c-4114-91c8-b08e0102bfed.gif" align = "center" height = "900rm">

## Built With

* [UIKit] - To build user interfaces across all Apple platforms.
* [MenuList] - As a third-party library to implement menu list.
* [CoreData] - Database to work with data. 

## Pods to install

```
platform :ios, '16.0'
post_install do |installer|
    sharedLibrary = installer.aggregate_targets.find { |aggregate_target| aggregate_target.name == 'Pods-[MY_FRAMEWORK_TARGET]' }
    installer.aggregate_targets.each do |aggregate_target|
        if aggregate_target.name == 'Pods-[MY_APP_TARGET]'
            aggregate_target.xcconfigs.each do |config_name, config_file|
                sharedLibraryPodTargets = sharedLibrary.pod_targets
                aggregate_target.pod_targets.select { |pod_target| sharedLibraryPodTargets.include?(pod_target) }.each do |pod_target|
                    pod_target.specs.each do |spec|
                        frameworkPaths = unless spec.attributes_hash['ios'].nil? then spec.attributes_hash['ios']['vendored_frameworks'] else spec.attributes_hash['vendored_frameworks'] end || Set.new
                        frameworkNames = Array(frameworkPaths).map(&:to_s).map do |filename|
                            extension = File.extname filename
                            File.basename filename, extension
                        end
                    end
                    frameworkNames.each do |name|
                        if name != '[DUPLICATED_FRAMEWORK_1]' && name != '[DUPLICATED_FRAMEWORK_2]'
                            raise("Script is trying to remove unwanted flags: #{name}. Check it out!")
                        end
                        puts "Removing #{name} from OTHER_LDFLAGS"
                        config_file.frameworks.delete(name)
                    end
                end
            end
            xcconfig_path = aggregate_target.xcconfig_path(config_name)
            config_file.save_as(xcconfig_path)
        end
    end
end
target 'DeliveryApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

 pod 'SideMenu'

end
```
