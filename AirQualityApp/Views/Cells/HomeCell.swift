//
//  HomeCell.swift
//  AirQualityApp
//
//  Created by Yogesh Singh on 02/07/21.
//

import UIKit

class HomeCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var indexLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var leftView: UIView!
  @IBOutlet weak var bgView: UIView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setupContentView()
    setupBGView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }

  private func setupContentView() {
    contentView.backgroundColor = UIColor.clear
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
    contentView.layer.shadowOpacity = 0.7
    contentView.layer.shadowRadius = 4.0
  }
  
  private func setupBGView() {
    bgView.backgroundColor = UIColor.white
    bgView.layer.cornerRadius = 10
    bgView.layer.masksToBounds = true
  }
  
  func loadEntity(_ model: AQIModel) {
    nameLabel.text = model.city
    indexLabel.text = model.aqiValue
    descriptionLabel.text = model.aqi.description
    leftView.backgroundColor = model.aqi.color
  }
  
}
