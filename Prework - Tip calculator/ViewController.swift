//
//  ViewController.swift
//  Prework - Tip calculator
//
//  Created by Haonan Wang on 2/2/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let thank = ["Cheers to you", "You're great", "Thank you so much", "You're my hero"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return thank.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return thank[row]
    }

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControll: UISegmentedControl!
    @IBOutlet weak var customSlider: UISlider!
    @IBOutlet weak var splittedVal: UILabel!
    @IBOutlet weak var splitNum: UITextField!
    @IBOutlet weak var thankWords: UIPickerView!
    @IBOutlet weak var modeSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tip Calculator"
        
        thankWords.delegate = self
        thankWords.dataSource = self
        billAmountTextField.becomeFirstResponder()
        
        let date = UserDefaults.standard.object(forKey: "TerminatedAt") as? Date ?? Date()
        let timeSince = Calendar.current.dateComponents([.second], from: date, to: Date())
        let timeAfterTerminate = timeSince.second ?? 0
        if(timeAfterTerminate <= 600) {
            let defaults = UserDefaults.standard
            billAmountTextField.text = defaults.string(forKey: "lastBill")
        }
    }


    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentage = [0.15, 0.18, 0.20]
        let split = Int(splitNum.text!)!
        
        let tip = bill * tipPercentage[tipControll.selectedSegmentIndex]
        let total = tip + bill
        let splitted: Double = Double((tip + bill)) / Double(split)
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        splittedVal.text = String(format: "$%.2f", splitted)
        
        if tip <= bill * 0.15 {
            thankWords.selectRow(0, inComponent: 0, animated: true)
        }
        else if tip <= bill * 0.18 {
            thankWords.selectRow(1, inComponent: 0, animated: true)
        }
        else if tip <= bill * 0.25 {
            thankWords.selectRow(2, inComponent: 0, animated: true)
        }
        else {
            thankWords.selectRow(3, inComponent: 0, animated: true)
        }
    }
    
    @IBAction func calculateTip1(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentage = Double(customSlider.value)
        let split = Int(splitNum.text!)!
        
        let tip = bill * tipPercentage
        let total = tip + bill
        let splitted: Double = Double(tip + bill) / Double(split)
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        splittedVal.text = String(format: "$%.2f", splitted)
        
        if tip <= bill * 0.15 {
            thankWords.selectRow(0, inComponent: 0, animated: true)
        }
        else if tip <= bill * 0.18 {
            thankWords.selectRow(1, inComponent: 0, animated: true)
        }
        else if tip <= bill * 0.25 {
            thankWords.selectRow(2, inComponent: 0, animated: true)
        }
        else {
            thankWords.selectRow(3, inComponent: 0, animated: true)
        }
    }
    
    @IBAction func rememberBill (_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(billAmountTextField.text, forKey: "lastBill")
        defaults.synchronize()
    }
    
    @IBAction func darkModeSwitch(_ sender: Any) {
        if modeSwitch.isOn {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
}

