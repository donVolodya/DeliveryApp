//
//  MenuList.swift
//  DeliveryApp
//
//  Created by Vova Novosad on 02.11.2022.
//

import UIKit
import CoreData
import SideMenu


//MARK: - Protocol for MenuList

protocol MenuListDelegate {
    func menuItemSelected(name: CategoryData)
}

//MARK: - TableView Methods
    
class MenuList : UITableViewController, UINavigationBarDelegate
{
        public var delegate : MenuListDelegate?
        var foodArray = [CategoryData]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        init(with foodArray: [CategoryData]){
            self.foodArray = foodArray
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            loadCategories()
            //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "marketCell")
            tableView.rowHeight = 70
        }
        
        
      override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return foodArray.count
        }
        
        
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell",for: indexPath)
            let category = foodArray[indexPath.row]
           
            cell.textLabel?.text = category.categoryName
           
            if let data = category.value(forKeyPath: "categoryLogo") as? Data
            {
                cell.imageView?.image = UIImage(data: data)
            }else
           {
               cell.imageView?.image = UIImage(named: "fish.png")
           }
           
            
            return cell
        }
        
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let selectedCategory = foodArray[indexPath.row]
            delegate?.menuItemSelected(name: selectedCategory)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ProductsVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.selectedCategory = foodArray[indexPath.row]
        }
    }
        

        
        
        
        
        //MARK: - Work with Data
        func loadCategories()
        {
            let request : NSFetchRequest<CategoryData> = CategoryData.fetchRequest()
            do{
                foodArray = try context.fetch(request)
            }catch{
                print("Load data error : ", error)
            }
            
            tableView.reloadData()
        }
        
    }
