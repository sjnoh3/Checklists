import UIKit

class ChecklistController: UIViewController {

  let tableView = UITableView()
  var items: [ListCellPresentable] = []
  
  struct Cells {
    static let listCell = "ListCell"
  }
  
  // MARK:- viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setDummyData()
    
    configureTableView()
    configureNavBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isTranslucent = true
  }
  
  
  func setDummyData() {
    for i in 0...8 {
      var newItem = ChecklistItem()
      newItem.checked = (i%2 == 0)
      newItem.text = "Content \(i+1)"
      items.append(newItem)
    }
  }
  
  
  func configureNavBar() {
    title = "Checklist"
    navigationItem.setRightBarButton(UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addNew)), animated: true)
  }
  
  
  @objc private func addNew(){
    let itemDetailView = ItemDetailViewController()
    itemDetailView.delegate = self
    navigationController?.pushViewController(itemDetailView, animated: true)
  }
  
  
  func configureTableView() {
    view.addSubview(tableView)
    setTableViewDelegates()
//    tableView.rowHeight = 40
    tableView.register(ListCell.self, forCellReuseIdentifier: Cells.listCell)
    // set constraints
    tableView.pin(to: view)
  }
  
  
  func setTableViewDelegates() {
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the item to be re-orderable.
      return true
  }
  */

  // MARK:- Data
  
}


extension ChecklistController: ItemDetailViewControllerDelegate {
  
  // MARK: - ItemDetailVew Protocols
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewControllerDidAdd(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
  
    let newRowIndex = items.count
    print(item.text)
    items.append(item)

    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    navigationController?.popViewController(animated:true)
  }
}


// UITableViewDelegate:
// Methods for managing secions, configuring section headers, footers, deleting and reordering cells, and PERFORMING other ACTIONS IN A TABLE VIEW.
// UITableViewDataSource:
//  The methods that an object adopts to manage data and PROVIDE CELLS FOR A TABLE VIEW.

extension ChecklistController: UITableViewDelegate, UITableViewDataSource {
  // MARK:- TV Data Source Delegates
  // REQUIRED..
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  
  // Ask the data source for a cell to insert in a particular location of the table view
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Cells.listCell, for: indexPath) as! ListCell
    let item = items[indexPath.row]
    cell.set(item: item)
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let cell = tableView.cellForRow(at: indexPath) as! ListCell
    var item = items[indexPath.row]
//    item.checked.toggle()
    item.toggle()
    var newItem = ChecklistItem()
    newItem.text = item.title
    newItem.checked = item.isChecked
//    items[indexPath.row] = item
//    cell.set(item: item)
//    tableView.reloadData()
//    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
  
  
  // OPTIONAL..
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  // MARK:- TableView Delegates
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  
//  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    // 1
//    items.remove(at: indexPath.row)
//
//    // 2
//    let indexPaths = [indexPath]
//    tableView.deleteRows(at: indexPaths, with: .automatic)
//  }
  
  
  // MARK: - Cell Contents
//  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
//    let image = cell.viewWithTag(1001) as! UIImageView
//    image.isHidden.toggle()
//  }
//
//  
//  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
//    let label = cell.viewWithTag(1002) as! UILabel
//    label.text = item.text
//  }
}



