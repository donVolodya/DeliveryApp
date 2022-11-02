//
//  MarketVC.swift
//  DeliveryApp
//
//  Created by Vova Novosad on 05.10.2022.
//

import UIKit
import SideMenu
import CoreData

class MarketVC: UIViewController, MenuListDelegate, UINavigationBarDelegate {
    
    func menuItemSelected(name: CategoryData) {
        menu?.dismiss(animated: true, completion: {
    
        })
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
        
        addChildController()
    }
    
    @IBAction func didTapMenu()
    {
        present(menu!, animated: true)
    }
    
    private func addChildController()
    {
        addChild(ProductsVC())
        view.addSubview(ProductsVC().view)
        
        ProductsVC().view.frame = view.bounds
        ProductsVC().didMove(toParent: self)
    }
    

}




