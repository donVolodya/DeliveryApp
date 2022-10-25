//
//  MarketVC.swift
//  DeliveryApp
//
//  Created by Vova Novosad on 05.10.2022.
//

import UIKit
import SideMenu

class MarketVC: UIViewController {

    var menu : SideMenuNavigationController?
    let menuList = MenuList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("File path: ",FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        menu = SideMenuNavigationController(rootViewController: MenuList())
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
        let foodArray = ["Fruits","Vegetables","Fish","Meat"]
        let images = [UIImage(named: "fruit"),UIImage(named: "vegetable"),UIImage(named: "fish"),UIImage(named: "meat")]
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "marketCell")
        }
        
        
      override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return foodArray.count
        }
        
        
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell",for: indexPath)
            
            cell.textLabel?.text = foodArray[indexPath.row]
            cell.imageView?.image = images[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }
        
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
