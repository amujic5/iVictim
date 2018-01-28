platform :ios, ‘9.0’
use_frameworks!

target 'iVictim' do
    pod 'RealmSwift'
    pod 'Locksmith'
    pod 'CryptoSwift'

    swift4 = ['RealmSwift', 'Locksmith', 'CryptoSwift']


    post_install do |installer|
        installer.pods_project.targets.each do |target|
            if swift4.include?(target.name)
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = '4.0'
                end
            else
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = '3.2'
                end
            end
            
            target.build_configurations.each do |config|
                if target.name == "Sherlock"
                    config.build_settings["OTHER_LDFLAGS"] = '$(inherited) "-ObjC" "-all_load"'
                end
            end
        end
    end

end
