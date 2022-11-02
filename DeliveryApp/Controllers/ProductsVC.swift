import UIKit
import CoreData

class ProductsVC: UITableViewController {

    var productArray = [Product]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var selectedCategory : MenuList?{
        didSet{
            // Відбудеться як тільки в обраній категорії зʼявиться якесь значення
            loadProducts()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "productCell")
    }


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
    
    func loadProducts(with request: NSFetchRequest<Product> = Product.fetchRequest())
    {
        do {
            productArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }



}
