//
//  UIView+Ext.swift
//  Checklist_NoSB
//
//  Created by Seok Jun Noh on 9/27/21.
//

import UIKit

extension UIView {
  func pin(to superView: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superView.topAnchor),
      leadingAnchor.constraint(equalTo: superView.leadingAnchor),
      trailingAnchor.constraint(equalTo: superView.trailingAnchor),
      bottomAnchor.constraint(equalTo: superView.bottomAnchor)
    ])
  }
}
