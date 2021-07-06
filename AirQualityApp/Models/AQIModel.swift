//
//  AQIModel.swift
//  AirQualityApp
//
//  Created by Yogesh Singh on 02/07/21.
//

import Foundation
import UIKit

struct AQIModel {
  let city: String
  let aqiValue: String
  let aqi: AQI
}


extension AQIModel: Decodable {
  enum CodingKeys: String, CodingKey {
    case city, aqi
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    city = try values.decode(String.self, forKey: .city)
    let result = try values.decode(Double.self, forKey: .aqi)
    aqiValue = String(format: "%.2f", result)
    aqi = AQI(rawValue: Int(result)) ?? .good
  }
}

extension AQIModel: Equatable {}

func ==(lhs: AQIModel, rhs: AQIModel) -> Bool {
  return lhs.city == rhs.city
}
