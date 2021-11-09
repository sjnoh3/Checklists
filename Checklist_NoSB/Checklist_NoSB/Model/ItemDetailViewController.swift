import UIKit

protocol ItemDetailViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  func itemDetailViewControllerDidAdd(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
}

struct Cells {
  static let textCell = "TextCell"
}


class ItemDetailViewController: UIViewController {

  let tableView = UITableView()
  let textField: UITextField = UITextField()
  
  weak var delegate: ItemDetailViewControllerDelegate?
  
  // MARK:- viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationController?.navigationBar.isTranslucent = false
    configureNavBar()
//    configureTableView()
    configureTextField()
  }
  
  
  func configureNavBar() {
    title = "Add Item"
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addItem))
  }
  

  func configureTableView() {
    view.addSubview(tableView)
    setTableViewDelegates()
    tableView.rowHeight = 40
    tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: Cells.textCell)
    tableView.pin(to: view)
    tableView.backgroundColor = .systemGray5
  }
  
  
  func setTableViewDelegates() {
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  
  
  @objc private func addItem() {
    var item = ChecklistItem()
    print(textField.text!)
    if textField.hasText {
      item.text = textField.text ?? "This should have not been added..."
      delegate?.itemDetailViewControllerDidAdd(self, didFinishAdding: item)
      return
    }
    delegate?.itemDetailViewControllerDidCancel(self)
  }
  
  
  @objc private func cancel() {
    delegate?.itemDetailViewControllerDidCancel(self)    
  }
  
  
  private func configureTextField() {
    guard textField.superview != view else {
      return
    }
    view.addSubview(textField)
    setTextFieldConstraints()
    textField.placeholder = "Enter a value"
    textField.font = UIFont.systemFont(ofSize: 20)
    textField.becomeFirstResponder()
  }
  
  
  func setTextFieldConstraints() {
    textField.translatesAutoresizingMaskIntoConstraints                                       = false
    textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive    = true
    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    textField.topAnchor.constraint(equalTo: view.topAnchor).isActive            = true
//    textField.heightAnchor.constraint(equalToConstant: 80).isActive                           = true
  }
  
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: Cells.textCell, for: indexPath)
//
//    return cell
//  }
//
//
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 1
//  }

}


extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  // MARK:- TV DataSource/Delegate
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Cells.textCell, for: indexPath) as! TextFieldTableViewCell
    
    return cell
  }
}



/*
 Data model - change to 'struct'
 NSOperation, NSOperationQ - iOS concurrency / **GCD (grand central dispatch)
 */
