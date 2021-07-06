//
//  Enums.swift
//  AirQualityApp
//
//  Created by Yogesh Singh on 06/07/21.
//

import Foundation
import UIKit

enum AQI: Int {
  case good
  case satisfactory
  case moderate
  case poor
  case veryPoor
  case severe
  
  init?(rawValue: Int) {
    switch rawValue {
    case 0...50: self = .good
    case 51...100: self = .satisfactory
    case 101...200: self = .moderate
    case 201...300: self = .poor
    case 301...400: self = .veryPoor
    default: self = .severe
    }
  }
  
  var color: UIColor {
    switch self {
    case .good:
      return UIColor(red: 0.35, green: 0.65, blue: 0.33, alpha: 1.00)
    case .satisfactory:
      return UIColor(red: 0.64, green: 0.78, blue: 0.36, alpha: 1.00)
    case .moderate:
      return UIColor(red: 1.00, green: 0.96, blue: 0.29, alpha: 1.00)
    case .poor:
      return UIColor(red: 0.94, green: 0.61, blue: 0.25, alpha: 1.00)
    case .veryPoor:
      return UIColor(red: 0.91, green: 0.25, blue: 0.23, alpha: 1.00)
    case .severe:
      return UIColor(red: 0.68, green: 0.18, blue: 0.16, alpha: 1.00)
    }
  }
  
  var title: String {
    switch self {
    case .good: return "Good"
    case .satisfactory: return "Satisfactory"
    case .moderate: return "Moderate"
    case .poor: return "Poor"
    case .veryPoor: return "Very Poor"
    case .severe: return "Severe"
    }
  }
  
  var description: String {
    switch self {
    case .good: return "Air quality is good, and air pollution poses little or no risk."
    case .satisfactory: return "Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
    case .moderate: return "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
    case .poor: return "Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
    case .veryPoor: return "Health alert: The risk of health effects is increased for everyone."
    case .severe: return "Health warning of emergency conditions: everyone is more likely to be affected."
    }
  }
}
