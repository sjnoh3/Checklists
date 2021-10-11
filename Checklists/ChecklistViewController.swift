//
//  ViewController.swift
//  Checklists
//
//  Created by Seok Jun Noh on 9/3/21.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
  // MARK: - Delegates
  func itemDetailViewControllerDidCancel(
    _ controller: ItemDetailViewController
  ) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishAdding item: ChecklistItem
  ) {
    let newRowIndex = items.count
    items.append(item)

    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    navigationController?.popViewController(animated:true)
    
    saveChecklistItems()
  }
  
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishEditing item: ChecklistItem
  ) {
    if let index = items.firstIndex(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
      }
    }
    navigationController?.popViewController(animated: true)
    
    saveChecklistItems()
  }


  
    var items = [ChecklistItem]()

  // MARK: - viewDidLoad
    override func viewDidLoad() {
      super.viewDidLoad()
      
      navigationController?.navigationBar.prefersLargeTitles = true
      
      loadChecklistItems()
    }

    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      return items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)

      let item = items[indexPath.row]

      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
      return cell
    }



    
//    override func tableView(
//        _ tableView: UITableView,
//        cellForRowAt indexPath: IndexPath
//    ) -> UITableViewCell {
//        // Gets a copy of the prototype cell (Either a new one or a recycled one)
//        // IndexPath is an object that points to a specific row in the table. When the table view asks the data source for a cell, you can look at the row number inside the indexPath.row property to find out the row for which the cell is intended.
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: "ChecklistItem",
//            for: indexPath)
//
//        let label = cell.viewWithTag(1000) as! UILabel
//
//        if indexPath.row % 5 == 0 {
//            label.text = row0text
//        } else if indexPath.row % 5  == 1 {
//            label.text = row1text
//        } else if indexPath.row % 5  == 2 {
//            label.text = row2text
//        } else if indexPath.row % 5  == 3 {
//            label.text = row3text
//        } else if indexPath.row % 5  == 4 {
//            label.text = row4text
//        }
//
//        return cell
//    }
  
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.checked.toggle()
      configureCheckmark(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
    
    saveChecklistItems()
  }

  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    // 1
    items.remove(at: indexPath.row)

    // 2
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
    
    saveChecklistItems()
  }

  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // 1
    if segue.identifier == "AddItem" {
      // 2
      let controller = segue.destination as! ItemDetailViewController
      // 3
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self
      
      // tableView.indexPath(for:)'s return type is IndexPath? (meaning the return value can be nil)
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        controller.itemToEdit = items[indexPath.row]
      }
    }
  }

  // MARK: - Cell Contents
  func configureCheckmark(
    for cell: UITableViewCell,
    with item: ChecklistItem
  ) {
    let label = cell.viewWithTag(1001) as! UILabel

    if item.checked {
      label.text = "√"
    } else {
      label.text = ""
    }
  }


  func configureText(
    for cell: UITableViewCell,
    with item: ChecklistItem
  ) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  
//  No longer need this function because the Delegate function handles it.
//  @IBAction func addItem() {
//    let newRowIndex = items.count
//
//    let item = ChecklistItem()
//    item.text = "I am a new row"
//    item.checked = true
//    items.append(item)
//
//    let indexPath = IndexPath(row: newRowIndex, section: 0)
//    let indexPaths = [indexPath]
//    tableView.insertRows(at: indexPaths, with: .automatic)
//  }
  
  // MARK: - Data Storing and Loading
  // Returns the full path to the Documents folder.
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(
      for: .documentDirectory,
      in: .userDomainMask)
    return paths[0]
  }

  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
  func saveChecklistItems() {
    // 1
    let encoder = PropertyListEncoder()
    // 2
    do {
      // 3
      let data = try encoder.encode(items)
      // 4
      try data.write(
        to: dataFilePath(),
        options: Data.WritingOptions.atomic)
      // 5
    } catch {
      // 6
      print("Error encoding item array: \(error.localizedDescription)")
    }
  }

  func loadChecklistItems() {
    // 1
    let path = dataFilePath()
    // 2
    if let data = try? Data(contentsOf: path) {
      // 3
      let decoder = PropertyListDecoder()
      do {
        // 4
        items = try decoder.decode(
          [ChecklistItem].self,
          from: data)
      } catch {
        print("Error decoding item array: \(error.localizedDescription)")
      }
    }
  }


}


