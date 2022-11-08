//
//  UIDevice+DeviceModel.swift
//  Apollo
//
//  Created by Christian Selig on 2017-01-10.
//  Copyright © 2017 Christian Selig. All rights reserved.
//

import UIKit

enum DeviceModel: String {
    case iPodTouch5
    case iPodTouch6
    case iPhone4
    case iPhone4s
    case iPhone5
    case iPhone5c
    case iPhone5s
    case iPhone6
    case iPhone6Plus
    case iPhone6s
    case iPhone6sPlus
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhone12
    case iPhone12Mini
    case iPhone12Pro
    case iPhone12ProMax
    case iPhone13
    case iPhone13Mini
    case iPhone13Pro
    case iPhone13ProMax
    case iPhone14Pro
    case iPhone14ProMax
    case iPhone14
    case iPhone14Plus
    case iPhoneSE
    case iPad2
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadPro9Point7
    case iPadPro12Point9
    case iPad5
    case iPadPro12Point9Gen2
    case iPadPro10Point5
    case iPad6
    case iPadPro11
    case iPadPro11Gen2
    case iPadPro11Gen3
    case iPadPro12Point9Gen3
    case iPadPro12Point9Gen4
    case iPadPro12Point9Gen5
    case iPadAirGen4
    case iPadMini6
    case iPadPro
    case AppleTV
    case simulator
    
    var hasOLEDScreen: Bool {
        return [.iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhone11Pro, .iPhone11ProMax, .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax, .iPhone13Mini, .iPhone13, .iPhone13Pro, .iPhone13ProMax, .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax].contains(self)
    }

    var hasHomeIndicator: Bool {
        return [.iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR, .iPadPro11, .iPadPro11Gen2, .iPadAirGen4, .iPadPro12Point9Gen3, .iPadPro12Point9Gen4, .iPhone11, .iPhone11Pro, .iPhone11ProMax, .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax, .iPhone13Mini, .iPhone13, .iPhone13Pro, .iPhone13ProMax, .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax, .iPadMini6, .iPadPro11Gen3, .iPadPro12Point9Gen5].contains(self)
    }
    
    var hasRoundedCorners: Bool {
        return [.iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR, .iPadPro11, .iPadPro11Gen2, .iPadPro12Point9Gen3, .iPadAirGen4, .iPadMini6, .iPadPro12Point9Gen4, .iPhone11, .iPhone11Pro, .iPhone11ProMax, .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax, .iPhone13Mini, .iPhone13, .iPhone13Pro, .iPhone13ProMax, .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax, .iPadPro11Gen3, .iPadPro12Point9Gen5].contains(self)
    }
    
    var hasNotch: Bool {
        return [.iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR, .iPhone11, .iPhone11Pro, .iPhone11ProMax, .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax, .iPhone13Mini, .iPhone13, .iPhone13Pro, .iPhone13ProMax, .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax].contains(self)
    }
    
    var hasFaceID: Bool {
        return [.iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR, .iPadPro11, .iPadPro11Gen2, .iPadPro12Point9Gen3, .iPadPro12Point9Gen4, .iPhone11, .iPhone11Pro, .iPhone11ProMax, .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax, .iPhone13Mini, .iPhone13, .iPhone13Pro, .iPhone13ProMax, .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax, .iPadPro11Gen3, .iPadPro12Point9Gen5].contains(self)
    }
    
    var hasDynamicIsland: Bool {
        return [.iPhone14Pro, .iPhone14ProMax].contains(self)
    }
}

extension UIDevice {
    var deviceModel: DeviceModel? {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        if ["i386", "x86_64", "arm64"].contains(identifier) {
            return identifySimulator()
        }
        
        // NOTE: Source can be updated from here: https://github.com/devicekit/DeviceKit/blob/master/Source/Device.generated.swift
        
        switch identifier {
        case "iPod5,1":                                    return .iPodTouch5
        case "iPod7,1":                                    return .iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":        return .iPhone4
        case "iPhone4,1":                                  return .iPhone4s
        case "iPhone5,1", "iPhone5,2":                     return .iPhone5
        case "iPhone5,3", "iPhone5,4":                     return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                     return .iPhone5s
        case "iPhone7,2":                                  return .iPhone6
        case "iPhone7,1":                                  return .iPhone6Plus
        case "iPhone8,1":                                  return .iPhone6s
        case "iPhone8,2":                                  return .iPhone6sPlus
        case "iPhone9,1", "iPhone9,3":                     return .iPhone7
        case "iPhone9,2", "iPhone9,4":                     return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":                   return .iPhone8
        case "iPhone10,2", "iPhone10,5":                   return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                   return .iPhoneX
        case "iPhone11,2":                                 return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":                   return .iPhoneXSMax
        case "iPhone11,8":                                 return .iPhoneXR
        case "iPhone12,1":                                 return .iPhone11
        case "iPhone12,3":                                 return .iPhone11Pro
        case "iPhone12,5":                                 return .iPhone11ProMax
        case "iPhone8,4":                                  return .iPhoneSE
        case "iPhone13,2":                                 return .iPhone12
        case "iPhone13,1":                                 return .iPhone12Mini
        case "iPhone13,3":                                 return .iPhone12Pro
        case "iPhone13,4":                                 return .iPhone12ProMax
        case "iPhone14,5":                                 return .iPhone13
        case "iPhone14,4":                                 return .iPhone13Mini
        case "iPhone14,2":                                 return .iPhone13Pro
        case "iPhone14,3":                                 return .iPhone13ProMax
        case "iPhone15,2":                                 return .iPhone14Pro
        case "iPhone15,3":                                 return .iPhone14ProMax
        case "iPhone14,7":                                 return .iPhone14
        case "iPhone14,8":                                 return .iPhone14Plus
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":              return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":              return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":              return .iPadAir
        case "iPad5,3", "iPad5,4":                         return .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":              return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":              return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":              return .iPadMini3
        case "iPad5,1", "iPad5,2":                         return .iPadMini4
        case "iPad6,3", "iPad6,4":                         return .iPadPro9Point7
        case "iPad6,7", "iPad6,8":                         return .iPadPro12Point9
        case "iPad6,11", "iPad6,12":                       return .iPad5
        case "iPad7,1", "iPad7,2":                         return .iPadPro12Point9Gen2
        case "iPad7,3", "iPad7,4":                         return .iPadPro10Point5
        case "iPad7,5", "iPad7,6":                         return .iPad6
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":   return .iPadPro11
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":   return .iPadPro12Point9Gen3
        case "iPad13,1", "iPad13,2":                       return .iPadAirGen4
        case "iPad8,9", "iPad8,10":                        return .iPadPro11Gen2
        case "iPad8,11", "iPad8,12":                       return .iPadPro12Point9Gen4
        case "iPad14,2":                                   return .iPadMini6
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7": return .iPadPro11Gen3
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return .iPadPro12Point9Gen5
        case "AppleTV5,3":                                 return .AppleTV
        default:                                           return nil
        }
    }
    
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    private func identifySimulator() -> DeviceModel? {
        guard let simulatorName = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] else { return nil }
        let deviceModelRaw = simulatorName.replacingOccurrences(of: " ", with: "")
        return DeviceModel(rawValue: deviceModelRaw)
    }
    
    // MARK: - Ryan's Addition
    
    static var dynamicIslandCompactFrame: CGRect? {
        guard let keyWindow = UIApplication.shared.windows.first,
              let device = UIDevice.current.deviceModel else { return nil }

        // True if the device has "Display Zoom" set to "Zoomed" rather than "Standard" which changes screen coordinates and thus where the cutout is. Note that this equality check has only been verified on iPhone 14 Pro and iPhone 14 Pro Max
        let isZoomed = UIScreen.main.scale != UIScreen.main.nativeScale

        if isZoomed {
            if device == .iPhone14Pro {
                let compactWidth = 124.0
                return CGRect(x: (keyWindow.bounds.width - compactWidth)/2,
                              y: 11.5,
                              width: compactWidth,
                              height: 35.5)

            } else if device == .iPhone14ProMax {
                let compactWidth = 124.0
                return CGRect(x: (keyWindow.bounds.width - compactWidth)/2,
                              y: 11.5,
                              width: compactWidth,
                              height: 35.5)
            } else {
                return nil
            }
        } else {
            let compactWidth = 124.0
            return CGRect(x: (keyWindow.bounds.width - compactWidth)/2,
                          y: 12,
                          width: compactWidth,
                          height: 35.5)
        }
    }

}

