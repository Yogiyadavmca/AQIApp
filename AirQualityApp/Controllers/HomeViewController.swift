//
//  ViewController.swift
//  AirQualityApp
//
//  Created by Yogesh Singh on 02/07/21.
//

import UIKit

class HomeViewController: UIViewController {

  
  let homeViewModel = HomeViewModel()
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  
    setupPage()
  }

  override func viewWillDisappear(_ animated: Bool) {
    stopFetchingAQI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    startFetchingAQI()
  }
  
  deinit {
    removeNotification()
  }
  
  // MARK: -
  private func setupPage() {
    setupNavigationBar()
    setupTable()
  }
  
  private func setupTable() {
    self.tableView.estimatedRowHeight = 100
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.tableFooterView = UIView()
  }
  
  private func setupNavigationBar() {
    self.title = Constants.ScreenName.Home
  }
    
  private func addNotification() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(enterForeground),
      name: UIScene.willEnterForegroundNotification,
      object: nil
    )

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(enterBackground),
      name: UIScene.didEnterBackgroundNotification,
      object: nil
    )
  }
  
  private func removeNotification() {
    NotificationCenter.default.removeObserver(self)
  }
  
  private func fetchAQI() {
    print("fetchAQI 1")
    homeViewModel.refreshList(after: Constants.Interval.fetch) { [weak self] in
      print("fetchAQI 2")
      DispatchQueue.main.async {
        print("fetchAQI 3")
        self?.tableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.fade)
      }
    }
  }
  
  private func navigateToDetailsPage(_ indexPath: IndexPath) {
    guard let model = homeViewModel.getAQIModel(index: indexPath.row) else {
      return
    }
    guard let viewController = storyboard?.instantiateViewController(
      identifier: Constants.Storyboard.Details,
      creator: { coder in
        DetailsViewController(aqiModel: model, coder: coder)
      }
    ) else {
      fatalError("Failed to create Details VC")
    }

    show(viewController, sender: self)
  }
  
  private func startFetchingAQI() {
    homeViewModel.openSocket()
    fetchAQI()
  }
  
  private func stopFetchingAQI() {
    homeViewModel.closeSocket()
    homeViewModel.stopFetchingData()
  }
  
  // MARK: - Ation
  @objc private func enterForeground() {
    startFetchingAQI()
  }
  
  @objc private func enterBackground() {
    stopFetchingAQI()
  }
}


// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homeViewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: HomeCell.identifier(),
      for: indexPath
    ) as! HomeCell
    
    //configure
    if let model = homeViewModel.getAQIModel(index: indexPath.row) {
      cell.loadEntity(model)
    }
        
    return cell
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigateToDetailsPage(indexPath)
  }
}
