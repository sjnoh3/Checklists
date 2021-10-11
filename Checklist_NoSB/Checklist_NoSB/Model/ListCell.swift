//
//  LabelCell.swift
//  Checklist_NoSB
//
//  Created by Seok Jun Noh on 9/21/21.
//

import UIKit

protocol ListCellPresentable {
  var isChecked: Bool { get }
  var title: String? { get }
}

class ListCell: UITableViewCell {
  let checkmarkImageView          = UIImageView()
  let contentLabel            = UILabel()
  let checkmarBackgroundView = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // Insetin
    contentView.addSubview(checkmarBackgroundView)
    contentView.addSubview(checkmarkImageView)
    contentView.addSubview(contentLabel)
    
    configureImageBackground()
    configureImageView()
//    configureLabel()
    setImageBackground()
    setImageConstraint()
    setLabelConstraint()
    
    selectionStyle = UITableViewCell.SelectionStyle.none
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func set(item: ListCellPresentable) {
    if !item.isChecked {
      checkmarkImageView.image  = nil
    }
    else {
      checkmarkImageView.image  = UIImage(systemName: "checkmark")
    }
    contentLabel.text = item.title
  }
  
  
  func configureImageView() {
    checkmarkImageView.contentMode          = .center
  }
  
  
  func configureImageBackground() {
//    checkmarkImageView.image                = UIImage(systemName: "")
    checkmarBackgroundView.clipsToBounds        = true
    checkmarBackgroundView.layer.cornerRadius   = 10
    checkmarBackgroundView.backgroundColor      = .systemYellow
    checkmarBackgroundView.contentMode          = .center
  }
  
//
//  func configureLabel() {
//    contentLabel.adjustsFontSizeToFitWidth  = true
//  }
  
  
  func setImageConstraint() {
    checkmarkImageView.translatesAutoresizingMaskIntoConstraints                                = false
    checkmarkImageView.centerYAnchor.constraint(equalTo: checkmarBackgroundView.centerYAnchor).isActive = true
    checkmarkImageView.centerXAnchor.constraint(equalTo: checkmarBackgroundView.centerXAnchor).isActive = true
  }
    
  func setImageBackground() {
    checkmarBackgroundView.translatesAutoresizingMaskIntoConstraints                                = false
    checkmarBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                = true
    checkmarBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive  = true
    checkmarBackgroundView.heightAnchor.constraint(equalToConstant: 30).isActive                    = true
    checkmarBackgroundView.widthAnchor.constraint(equalToConstant: 30).isActive                     = true
  }
  

  func setLabelConstraint() {
    contentLabel.translatesAutoresizingMaskIntoConstraints                                      = false
    contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                      = true
    contentLabel.leadingAnchor.constraint(equalTo: checkmarBackgroundView.trailingAnchor, constant: 12).isActive        = true
    contentLabel.heightAnchor.constraint(equalToConstant: 30).isActive                          = true
    contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive     = true
  }
  
}


