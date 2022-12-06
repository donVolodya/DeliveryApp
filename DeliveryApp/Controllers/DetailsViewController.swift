

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - VC elements
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var kilogramButton: UIButton!
    @IBOutlet weak var gramButton: UIButton!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    var name = ""
    var price = ""
    var image = UIImage()
    var finalPrice = Double()
    var amount = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productName.text = name
        productPrice.text = price
        productImage.image = image

    }
    
    @IBAction func weightTypeChanged(_ sender: UIButton)
    {
        kilogramButton.isSelected = false
        gramButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let priceMinusLetters =  String(price.dropLast(4))
        let buttonTitleAsANumber = Double(priceMinusLetters)!
        if buttonTitle == "Кг"
        {
            finalPrice = buttonTitleAsANumber
            kilogramButton.backgroundColor = .systemMint
            gramButton.backgroundColor = .white
            print("KG selected")
            
        }
        else if buttonTitle == "Гр"
        {
            finalPrice = buttonTitleAsANumber / 100
            gramButton.backgroundColor = .systemMint
            kilogramButton.backgroundColor = .white
            print("GR selected")
        }
        
    }
    

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        amountLabel.text = String(format: "%.0f", sender.value)
        amount = Int(sender.value)
    }
    

}
