//
//  ChecklistItem.swift
//  Checklist_NoSB
//
//  Created by Seok Jun Noh on 9/21/21.
//

import Foundation

struct ChecklistItem {
  var text: String? = ""
  var checked = false
  
  
}

extension ChecklistItem: ListCellPresentable {
  var isChecked: Bool {
    return checked
  }
  
  var title: String? {
    return text
  }
  
  mutating func toggle() {
    checked = !checked
  }
}
