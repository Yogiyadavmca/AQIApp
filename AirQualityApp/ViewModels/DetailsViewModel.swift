//
//  DetailsViewModel.swift
//  AirQualityApp
//
//  Created by Yogesh Singh on 06/07/21.
//

import Foundation

class DetailsViewModel {
  
  private let socketManager = SocketManager(socketURL: "ws://city-ws.herokuapp.com/")
  private var aqiModel: AQIModel
  private var timer: Timer?
  
  init(aqiModel: AQIModel) {
    self.aqiModel = aqiModel
  }
    
  func fetchAQIValue(every after: TimeInterval, handler: @escaping (AQIModel) -> Void) {
    self.timer = Timer.scheduledTimer(withTimeInterval: after, repeats: true) { [weak self] _ in
      guard let `self` = self else {
        return
      }
      self.fetchAQI {
        handler(self.aqiModel)
      }
    }
  }
    
  
  func openSocket() {
    socketManager.openSocket()
  }
  
  func closeSocket() {
    socketManager.closeSocket()
  }
  
  func stopFetchingAQI() {
    self.timer?.invalidate()
  }
  
  private func fetchAQI(handler: @escaping () -> Void) {
    socketManager.fetchData { result in
      switch result {
      case .success(let models):
        let results = models.filter({ (model) -> Bool in
          return model == self.aqiModel
        })
        if results.count > 0 {
          self.aqiModel = results[0]
        }
        handler()
      case .failure(let error):
        print(error)
        handler()
      }
    }
  }
  
}
