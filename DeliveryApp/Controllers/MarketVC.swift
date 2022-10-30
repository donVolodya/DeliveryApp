//
//  MarketVC.swift
//  DeliveryApp
//
//  Created by Vova Novosad on 05.10.2022.
//

import UIKit
import SideMenu
import CoreData

class MarketVC: UIViewController, UITableViewDelegate {
    var menu : SideMenuNavigationController?
    let menuList = MenuList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: menuList)
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func didTapMenu()
    {
        present(menu!, animated: true)
    }

}
//MARK: - TableView Methods
    
    class MenuList : UITableViewController
    {
        var foodArray = [CategoryData]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadCategories()
            
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
            performSegue(withIdentifier: "goToProducts", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! ProductsVC
            if let indexPath = tableView.indexPathForSelectedRow
            {
//                let products = foodArray.flatMap{
//                    $0.products?.allObjects as! [MenuList]
//                }
                destinationVC.selectedCategory = foodArray[indexPath.row] as? MenuList
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


