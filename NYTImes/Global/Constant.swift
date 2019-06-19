//
//  Constant.swift
//  Tex-Isle
//
//  Created by Vishal Gohel on 25/11/18.
//  Copyright © 2018 Vishal Gohel. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

//API VALUES DEFAULT CONSTANT
let API_URL_DEFAULT:String = "https://api.nytimes.com/svc" //LIVE
let API_VERSION = "v2"
let API_KEY = "qVvmf2hbPJHbxSYgAhBPxrwPmzGAnQUJ"

struct APP {
    static let title            = "NY Times"
}

//Application Specific Messages

struct APPERRORMESSAGES {
    static let  noNetwork            = "Please check your internet connection"
    static let serverError           = "We are unable to connect with server, please try again later"
    
}


//MARK:- ScreenSize & DeviceType
// Check screen size with device type
public struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

enum DeviceType: CustomStringConvertible, Equatable {
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
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPad2
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPad5
    case iPad6
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadPro9Inch
    case iPadPro12Inch
    case iPadPro12Inch2
    case iPadPro10Inch
    case homePod
    indirect case simulator(DeviceType)
    case unknown(String)
    
    public var description: String {
        switch self {
        case .iPodTouch5     : return "iPod Touch 5"
        case .iPodTouch6     : return "iPod Touch 6"
        case .iPhone4        : return "iPhone 4"
        case .iPhone4s       : return "iPhone 4s"
        case .iPhone5        : return "iPhone 5"
        case .iPhone5c       : return "iPhone 5c"
        case .iPhone5s       : return "iPhone 5s"
        case .iPhone6        : return "iPhone 6"
        case .iPhone6Plus    : return "iPhone 6 Plus"
        case .iPhone6s       : return "iPhone 6s"
        case .iPhone6sPlus   : return "iPhone 6s Plus"
        case .iPhone7        : return "iPhone 7"
        case .iPhone7Plus    : return "iPhone 7 Plus"
        case .iPhoneSE       : return "iPhone SE"
        case .iPhone8        : return "iPhone 8"
        case .iPhone8Plus    : return "iPhone 8 Plus"
        case .iPhoneX        : return "iPhone X"
        case .iPhoneXS        : return "iPhone XS"
        case .iPhoneXSMax     : return "iPhone XSMax"
        case .iPhoneXR        : return "iPhone XR"
        case .iPad2          : return "iPad 2"
        case .iPad3          : return "iPad 3"
        case .iPad4          : return "iPad 4"
        case .iPadAir        : return "iPad Air"
        case .iPadAir2       : return "iPad Air 2"
        case .iPad5          : return "iPad 5"
        case .iPad6          : return "iPad 6"
        case .iPadMini       : return "iPad Mini"
        case .iPadMini2      : return "iPad Mini 2"
        case .iPadMini3      : return "iPad Mini 3"
        case .iPadMini4      : return "iPad Mini 4"
        case .iPadPro9Inch   : return "iPad Pro (9.7-inch)"
        case .iPadPro12Inch  : return "iPad Pro (12.9-inch)"
        case .iPadPro12Inch2 : return "iPad Pro (12.9-inch) 2"
        case .iPadPro10Inch  : return "iPad Pro (10.5-inch)"
        case .homePod        : return "HomePod"
        case .simulator(let model): return "Simulator (\(model))"
        case .unknown(let identifier): return identifier
        }
    }
    
    public static func == (lhs: DeviceType, rhs: DeviceType) -> Bool {
        return lhs.description == rhs.description
    }
}

public struct DeviceIdentifier {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XR          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad //&& ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

//MARK:- Device Type
var deviceType: DeviceType {
    return mapToDevice(identifier: identifier)
}

/// Gets the identifier from the system, such as "iPhone7,1".
private var identifier: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let mirror = Mirror(reflecting: systemInfo.machine)
    
    let identifier = mirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return identifier
}

private func mapToDevice(identifier: String) -> DeviceType { //
    switch identifier {
    case "iPod5,1": return .iPodTouch5
    case "iPod7,1": return .iPodTouch6
    case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .iPhone4
    case "iPhone4,1": return .iPhone4s
    case "iPhone5,1", "iPhone5,2": return .iPhone5
    case "iPhone5,3", "iPhone5,4": return .iPhone5c
    case "iPhone6,1", "iPhone6,2": return .iPhone5s
    case "iPhone7,2": return .iPhone6
    case "iPhone7,1": return .iPhone6Plus
    case "iPhone8,1": return .iPhone6s
    case "iPhone8,2": return .iPhone6sPlus
    case "iPhone9,1", "iPhone9,3": return .iPhone7
    case "iPhone9,2", "iPhone9,4": return .iPhone7Plus
    case "iPhone8,4": return .iPhoneSE
    case "iPhone10,1", "iPhone10,4": return .iPhone8
    case "iPhone10,2", "iPhone10,5": return .iPhone8Plus
    case "iPhone10,3", "iPhone10,6": return .iPhoneX
    case "iPhone11,2": return .iPhoneXS
    case "iPhone11,4", "iPhone11,6": return .iPhoneXSMax
    case "iPhone11,8": return .iPhoneXR
        
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
    case "iPad3,1", "iPad3,2", "iPad3,3": return .iPad3
    case "iPad3,4", "iPad3,5", "iPad3,6": return .iPad4
    case "iPad4,1", "iPad4,2", "iPad4,3": return .iPadAir
    case "iPad5,3", "iPad5,4": return .iPadAir2
    case "iPad6,11", "iPad6,12": return .iPad5
    case "iPad7,5", "iPad7,6": return .iPad6
    case "iPad2,5", "iPad2,6", "iPad2,7": return .iPadMini
    case "iPad4,4", "iPad4,5", "iPad4,6": return .iPadMini2
    case "iPad4,7", "iPad4,8", "iPad4,9": return .iPadMini3
    case "iPad5,1", "iPad5,2": return .iPadMini4
    case "iPad6,3", "iPad6,4": return .iPadPro9Inch
    case "iPad6,7", "iPad6,8": return .iPadPro12Inch
    case "iPad7,1", "iPad7,2": return .iPadPro12Inch2
    case "iPad7,3", "iPad7,4": return .iPadPro10Inch
    case "AudioAccessory1,1": return .homePod
    case "i386", "x86_64": return .simulator(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))
    default: return .unknown(identifier)
    }
    
}

//MARK:- Application Themecolors
public struct ThemeColors {
    static let colorPrimaryLightGreen = UIColor(hex: "#47e4cc")
}


