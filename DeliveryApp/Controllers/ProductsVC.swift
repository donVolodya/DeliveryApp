import UIKit
import CoreData
import SideMenu

class ProductsVC: UITableViewController {

    var productArray = [Product]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let menuList = MenuList(with: [CategoryData]())
    
    
    
    var selectedCategory : CategoryData?{
        didSet{
            // Відбудеться як тільки в обраній категорії зʼявиться якесь значення
            loadProducts()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts()
        
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "productCell")
    }

//MARK: - TableView methods
    
  override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return productArray.count
    }


   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell",for: indexPath)
       let product = productArray[indexPath.row]
       
       cell.textLabel?.text = product.productName
       

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Work with Core Data
    
    func loadProducts(with request: NSFetchRequest<Product> = Product.fetchRequest(), predicate: NSPredicate? = nil)
    {
        let categoryPredicate = NSPredicate(format: "categories.categoryName MATCHES %@", selectedCategory!.categoryName!)

        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            productArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }

        tableView.reloadData()
    }



}


//MARK: - SearchBar methods

extension ProductsVC : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let request : NSFetchRequest<Product> = Product.fetchRequest()
    
        let predicate = NSPredicate(format: "productName CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "productName", ascending: true)]
        loadProducts(with: request, predicate: predicate)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadProducts()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
