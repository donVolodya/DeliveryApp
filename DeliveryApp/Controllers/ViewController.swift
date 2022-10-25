//
//  ViewController.swift
//  DeliveryApp
//
//  Created by Vova Novosad on 01.10.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("File path: ",FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }


}

