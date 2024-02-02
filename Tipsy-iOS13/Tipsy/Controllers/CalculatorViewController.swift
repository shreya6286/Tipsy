import UIKit

class CalculatorViewController: UIViewController {
    
    var tipSelected = 0.10
    var numberOfPeople = 2
    var amountTotal = 0.0
    var finalResult = "0.0"

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
        tipSelected = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        print(tipSelected)
        print(numberOfPeople)
        var amount = billTextField.text!
        if amount != "" {
            amountTotal = Double(amount)!
        }
        let result = amountTotal * (1 + tipSelected) / Double(numberOfPeople)
        finalResult = String(format: "%.2f", result)
        print(finalResult)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "goToResult" {
               let destinationVC = segue.destination as! ResultViewController
               destinationVC.result = finalResult
               destinationVC.tip = Int(tipSelected * 100)
               destinationVC.split = numberOfPeople
           }
       }
}

