//
//  DetailsViewController.swift
//  AirQualityApp
//
//  Created by Yogesh Singh on 06/07/21.
//

import UIKit
import DSFSparkline


class DetailsViewController: UIViewController {
  
  @IBOutlet weak var aqiValueLabel: UILabel!
  @IBOutlet weak var aqiStatus: UILabel!
  @IBOutlet weak var aqiLineGraph: DSFSparklineLineGraphView!
  
  
  private var lineGraphDataSource = DSFSparkline.DataSource(windowSize: 50, range: 0 ... 500)
  
  private let aqiModel: AQIModel
  private let viewModel: DetailsViewModel  
  
  // MARK: - Init
  init?(aqiModel: AQIModel, coder: NSCoder) {
    self.aqiModel = aqiModel
    self.viewModel = DetailsViewModel(aqiModel: aqiModel)
    super.init(coder: coder)
  }

  @available(*, unavailable, renamed: "init(aqiModel:coder:)")
  required init?(coder: NSCoder) {
      fatalError("use init(aqiModel:coder:)")
  }
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupPage()
    self.aqiLineGraph.dataSource = self.lineGraphDataSource
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.openSocket()
    fetchAQI()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    viewModel.closeSocket()
    viewModel.stopFetchingAQI()
  }
  
  // MARK: -
  private func setupPage() {
    setupNavigationBar()
    
    updateGraph(aqiModel)
  }
  
  
  private func setupNavigationBar() {
    self.title = aqiModel.city
  }
    
  private func fetchAQI() {
    viewModel.fetchAQIValue(every: Constants.Interval.fetch) { [weak self] (aqiModel) in
      DispatchQueue.main.async {
        self?.updateGraph(aqiModel)
      }
    }
  }
   
  private func updateGraph(_ model: AQIModel) {
    pushValueOnDataSource(model.aqiValue)
    aqiLineGraph.graphColor = model.aqi.color
    aqiStatus.text = model.aqi.title
    aqiValueLabel.text = model.aqiValue
  }
  
  private func pushValueOnDataSource(_ value: String) {
    if let number = NumberFormatter().number(from: value) {
      let floatValue = CGFloat(truncating: number)
      _ = lineGraphDataSource.push(value: floatValue)
    }
  }
}
