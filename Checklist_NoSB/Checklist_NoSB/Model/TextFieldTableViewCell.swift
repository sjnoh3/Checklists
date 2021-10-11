//
//  TextFieldTableViewCell.swift
//  Checklist_NoSB
//
//  Created by Seok Jun Noh on 9/28/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
  
//  class TextField: UITextField {
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//      return bounds.insetBy(dx: 24, dy: 0)
//    }
//
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//      return bounds.insetBy(dx: 24, dy: 0)
//    }
//
//    override var intrinsicContentSize: CGSize {
//      return .init(width: 0, height: 44)
//    }
//  }
//
//
//  let textField: UITextField = {
//    let tf = TextField()
//    tf.translatesAutoresizingMaskIntoConstraints = false
//    tf.placeholder = "Enter a new list"
//    return tf
//  }()
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
//    configureTextField()
    selectionStyle = UITableViewCell.SelectionStyle.none
  }
  
  
  func configureTextField() {
    let tf = UITextField(frame: bounds)
    tf.placeholder = "Enter a value"
    tf.becomeFirstResponder()
    tf.frame = bounds
    addSubview(tf)
  }
  
  
  
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
