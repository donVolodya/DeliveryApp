//
//  MarketVC.swift
//  DeliveryApp
//
//  Created by Vova Novosad on 05.10.2022.
//

import UIKit
import SideMenu
import CoreData

class MarketVC: UIViewController, MenuListDelegate, UITableViewDelegate {
    
   
    
    
    func menuItemSelected(name: CategoryData) {
        menu?.dismiss(animated: true, completion: {
        let selectionVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductsVC") as! ProductsVC
        self.navigationController?.pushViewController(selectionVC, animated: true)
        })
//        performSegue(withIdentifier: "goToProducts", sender: self)
    }
    
    var menu : SideMenuNavigationController?
    let menuList = MenuList(with: [CategoryData].init())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menu = SideMenuNavigationController(rootViewController: menuList)
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        menuList.delegate = self
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
    @IBAction func didTapMenu()
    {
        present(menu!, animated: true)
    }
    

}




