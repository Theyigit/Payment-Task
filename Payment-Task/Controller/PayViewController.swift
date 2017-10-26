//
//  ViewController.swift
//  Payment-Task
//
//  Created by Macbook on 24.10.2017.
//  Copyright © 2017 Yigit Yilmaz. All rights reserved.
//

import UIKit

class PayViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets and variables
    
    @IBOutlet var visaOutlet: UIButton!
    @IBOutlet var paypalOutlet: UIButton!
    @IBOutlet var applepayOutlet: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var addNewCardOutlet: UIButton!
    @IBOutlet var checkButtonOutlet: UIButton!
    var isChecked: Bool = true
    
    @IBOutlet var bookingLabel: UILabel!
    @IBOutlet var creditCardDetailsLabel: UILabel!
    @IBOutlet var holderNameLabel: UILabel!
    @IBOutlet var cardNumberLabel: UILabel!
    @IBOutlet var expDateLabel: UILabel!
    @IBOutlet var cvcLabel: UILabel!
    @IBOutlet var comingSoonLabel: UILabel!
    
    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var cardHolderNameTextField: UITextField!
    @IBOutlet var cardExpiryNameTextField: UITextField!
    @IBOutlet var securityCodeTextField: UITextField!
    
    @IBOutlet var payLabel: CustomLabel!
    @IBOutlet var creditCard: UIImageView!
    @IBOutlet var creditCardView: UIView!
    
    @IBOutlet var baseViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var labelTopConstraint: NSLayoutConstraint!
    @IBOutlet var continueButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var backgroundViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var payLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet var continueButtonTop: NSLayoutConstraint!
    
    @IBOutlet var containerView: UIStackView!
    @IBOutlet var backgroundView: UIView!
    
    let card = Card()
    let defaults = UserDefaults.standard
    
    //MARK:-
    
    //MARK: Button Actions
    
    @IBAction func visaButton(_ sender: Any) {
        visaOutlet.setTitleColor(UIColor.clear, for: UIControlState.normal)
        visaOutlet.setImage(UIImage(named: "Visa-selected"), for: UIControlState.normal)
        paypalOutlet.setImage(UIImage(named: "Paypal"), for: UIControlState.normal)
        applepayOutlet.setImage(UIImage(named: "ApplePay"), for: UIControlState.normal)
        
        containerViewManager()
        comingSoonLabel.isHidden = true
        bookingLabel.isHidden = false
        creditCardDetailsLabel.isHidden = false
    }
    @IBAction func paypalButton(_ sender: Any) {
        visaOutlet.setImage(UIImage(named: "Visa"), for: UIControlState.normal)
        paypalOutlet.setImage(UIImage(named: "PayPal-selected"), for: UIControlState.normal)
        applepayOutlet.setImage(UIImage(named: "ApplePay"), for: UIControlState.normal)
        
        comingSoonLabel.isHidden = false
        containerView.isHidden = true
        bookingLabel.isHidden = true
        creditCardDetailsLabel.isHidden = true
        creditCardView.isHidden = true
        creditCard.isHidden = true
        backgroundView.isHidden = false
        addNewCardOutlet.isHidden = true
    }
    @IBAction func applepayButton(_ sender: Any) {
        visaOutlet.setImage(UIImage(named: "Visa"), for: UIControlState.normal)
        paypalOutlet.setImage(UIImage(named: "Paypal"), for: UIControlState.normal)
        applepayOutlet.setImage(UIImage(named: "ApplePay-selected"), for: UIControlState.normal)
        
        comingSoonLabel.isHidden = false
        containerView.isHidden = true
        bookingLabel.isHidden = true
        creditCardDetailsLabel.isHidden = true
        creditCardView.isHidden = true
        creditCard.isHidden = true
        backgroundView.isHidden = false
        addNewCardOutlet.isHidden = true
    }
    @IBAction func continueButton(_ sender: Any) {
        
        if card.isStored != true{
            if self.cardNumberTextField.text != "" && self.cardHolderNameTextField.text != "" && self.cardExpiryNameTextField.text != "" && self.securityCodeTextField.text != ""{
                
                
                if isChecked == true{ // If check button is active then save informations.
                    defaults.set(true, forKey: "isStored")
                    defaults.set(self.cardHolderNameTextField.text, forKey: "holderName")
                    defaults.set(self.cardNumberTextField.text, forKey: "cardNumber")
                    defaults.set(self.cardExpiryNameTextField.text, forKey: "expDate")
                    defaults.set(self.securityCodeTextField.text, forKey: "cvc")
                    defaults.synchronize()
                }
                
                
                if self.cardNumberTextField.text != "" && self.cardHolderNameTextField.text != "" && self.cardExpiryNameTextField.text != "" && self.securityCodeTextField.text != ""{
                    
                    
                    if isChecked == true{ // If check button is active then save informations.
                        defaults.set(true, forKey: "isStored")
                        defaults.set(self.cardHolderNameTextField.text, forKey: "holderName")
                        defaults.set(self.cardNumberTextField.text, forKey: "cardNumber")
                        defaults.set(self.cardExpiryNameTextField.text, forKey: "expDate")
                        defaults.set(self.securityCodeTextField.text, forKey: "cvc")
                    }
                    
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Congratulations")
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Congratulations")
            self.present(vc!, animated: true, completion: nil)
        }
        

    }
    @IBAction func addNewCardButton(_ sender: Any) {
        
        creditCard.isHidden = true
        creditCardView.isHidden = true
        addNewCardOutlet.isHidden = true
        
        backgroundView.isHidden = false
        containerView.isHidden = false
        bookingLabel.isHidden = false
        creditCardDetailsLabel.isHidden = false
        bookingLabel.text = "Booking details will be sent."
        creditCardDetailsLabel.text = "CREDIT CARD DETAILS"
        
        let keyValueBool = defaults.bool(forKey:"isStored")
        defaults.removeObject(forKey: "isStored")
        var keyValueString = defaults.string(forKey:"expDate")
        defaults.removeObject(forKey: "expDate")
        keyValueString = defaults.string(forKey:"holderName")
        defaults.removeObject(forKey: "holderName")
        keyValueString = defaults.string(forKey:"cardNumber")
        defaults.removeObject(forKey: "cardNumber")
        keyValueString = defaults.string(forKey:"cvc")
        defaults.removeObject(forKey: "cvc")
    }
    
    @IBAction func checkButton(_ sender: Any) {
    
        if checkButtonOutlet.currentImage == UIImage(named: "Checked"){
            checkButtonOutlet.setImage(UIImage(named: "Unchecked"), for: UIControlState.normal)
            isChecked = false
        }else{
            checkButtonOutlet.setImage(UIImage(named: "Checked"), for: UIControlState.normal)
            isChecked = true
        }
    }
    
    //MARK:-
    
    //MARK: View loading functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerViewManager()
        
        
        comingSoonLabel.isHidden = true
        visaOutlet.adjustsImageWhenHighlighted = false
        paypalOutlet.adjustsImageWhenHighlighted = false
        applepayOutlet.adjustsImageWhenHighlighted = false
        checkButtonOutlet.adjustsImageWhenHighlighted = false
        
        self.cardNumberTextField.delegate = self
        self.cardHolderNameTextField.delegate = self
        self.cardExpiryNameTextField.delegate = self
        self.securityCodeTextField.delegate = self
        
        cardNumberTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        cardExpiryNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        securityCodeTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PayViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PayViewController.keyboardWillClose(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func containerViewManager(){
        // This func defines to shows whether saved card or card form.
        
        if card.isStored != nil{
            creditCard.isHidden = false
            creditCardView.isHidden = false
            addNewCardOutlet.isHidden = false
            backgroundView.isHidden = true
            containerView.isHidden = true
            bookingLabel.isHidden = true
            creditCardDetailsLabel.isHidden = true
            bookingLabel.text = ""
            creditCardDetailsLabel.text = ""
            loadCardInformation()
        }else{
            creditCard.isHidden = true
            creditCardView.isHidden = true
            addNewCardOutlet.isHidden = true
            backgroundView.isHidden = false
            containerView.isHidden = false
            bookingLabel.isHidden = false
            creditCardDetailsLabel.isHidden = false
            bookingLabel.text = "Booking details will be sent."
            creditCardDetailsLabel.text = "CREDIT CARD DETAILS"
        }
    }
    
    func loadCardInformation(){
        // This func builds saved card informations to label.
        
        holderNameLabel.text = card.holderName
        cardNumberLabel.text = (card.cardNumber?.components(separatedBy: " ")[0])! + " **** **** " + (card.cardNumber?.components(separatedBy: " ")[3])!
        expDateLabel.text = card.expDate
        cvcLabel.text = card.cvc
        
    }
    
    //MARK: -
    
    //MARK: TextField Implementations
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == self.cardHolderNameTextField {
            self.cardExpiryNameTextField.becomeFirstResponder()
        }
        return true
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        switch textField{
            case cardNumberTextField:
                if text?.utf16.count == 19{
                    self.cardHolderNameTextField.becomeFirstResponder()
                }
            case cardExpiryNameTextField:
                if text?.utf16.count == 5{
                    self.securityCodeTextField.becomeFirstResponder()
                }
            case securityCodeTextField:
                if text?.utf16.count == 3{
                   securityCodeTextField.resignFirstResponder()
                }
            default:
                break
            }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cardNumberTextField{
            if textField.text?.characters.count == 4 && string.characters.count != 0 {
                textField.text = textField.text! + " "
            }
            else if textField.text?.characters.count == 6 && string.characters.count == 0 {
                textField.text = String(textField.text!.characters.dropLast())
            }
            else if textField.text?.characters.count == 9 && string.characters.count != 0 {
                textField.text = textField.text! + " "
            }
            else if textField.text?.characters.count == 11 && string.characters.count == 0{
                textField.text = String(textField.text!.characters.dropLast())
            }
            else if textField.text?.characters.count == 14 && string.characters.count != 0 {
                textField.text = textField.text! + " "
            }
            else if textField.text?.characters.count == 16 && string.characters.count == 0 {
                textField.text = String(textField.text!.characters.dropLast())
            }
            if textField.text?.characters.count == 19 && string.characters.count != 0 {
                
                return false
                
            }else if textField.text?.characters.count == 0 && string.characters.count != 0 {
                textField.textColor = UIColor.red
            }else if (textField.text?.characters.count)! == 18 && string.characters.count != 0{
                textField.textColor = UIColor.black
            }
        }else if textField == cardExpiryNameTextField{
            if textField.text?.characters.count == 2 && string.characters.count != 0 {
                textField.text = textField.text! + "/"
            }
            if textField.text?.characters.count == 5 && string.characters.count != 0 {
                return false
            }else if textField.text?.characters.count == 0 && string.characters.count != 0 {
                textField.textColor = UIColor.red
            }else if (textField.text?.characters.count)! == 4 && string.characters.count != 0{
                textField.textColor = UIColor.black
            }
        }else if textField == securityCodeTextField{
            if textField.text?.characters.count == 3 && string.characters.count != 0 {
                securityCodeTextField.resignFirstResponder()
                return false
            }else if textField.text?.characters.count == 0 && string.characters.count != 0 {
                textField.textColor = UIColor.red
            }else if (textField.text?.characters.count)! == 2 && string.characters.count != 0{
                textField.textColor = UIColor.black
                
            }
        }
        
        return true
    }
    
    //MARK:-
    
    //MARK: Keyboard Functions
    
    @objc func keyboardWillShow(notification: NSNotification){
        
        let screenSize = UIScreen.main.bounds
        
        if let userInfoDict = notification.userInfo, let keyboardFrameValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardFrame = keyboardFrameValue.cgRectValue
            
            backButton.isEnabled = false
            backButton.isHidden = true
            creditCardDetailsLabel.isHidden = true
            bookingLabel.isHidden = true
            
            UIView.animate(withDuration: 0.6){
                if keyboardFrame.size.height >= 216.0{
                    self.continueButtonBottomConstraint.constant =  136
                     self.baseViewBottomConstraint.constant = -123
                }
                self.stackViewBottomConstraint.constant = self.continueButtonTop.constant + 8
                self.backgroundViewTopConstraint.constant = -65
                self.view.layoutIfNeeded()
                
                self.payLabel.font = self.payLabel.font.withSize(40)
                self.payLabel.characterSpacing = 0
                self.payLabelBottomConstraint.constant = 9.5
                
                if screenSize.height == 812.0{ // iPhone X
                    self.payLabel.font = self.payLabel.font.withSize(92)
                    self.payLabelBottomConstraint.constant = 20
                }
            }
        }
    }
    
    @objc func keyboardWillClose(notification: NSNotification){
        
        if let userInfoDict = notification.userInfo, let keyboardFrameValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardFrame = keyboardFrameValue.cgRectValue
            
            backButton.isEnabled = true
            backButton.isHidden = false
            creditCardDetailsLabel.isHidden = false
            bookingLabel.isHidden = false
            
            UIView.animate(withDuration: 0.8){
                
                self.baseViewBottomConstraint.constant = self.view.safeAreaInsets.bottom
                self.stackViewBottomConstraint.constant = 17
                self.continueButtonBottomConstraint.constant = 24
                self.backgroundViewTopConstraint.constant = 47
                
                self.payLabel.font = self.payLabel.font.withSize(92)
                self.payLabel.alpha = 1.0
                self.payLabel.characterSpacing = -8
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        cardNumberTextField.resignFirstResponder()
        cardHolderNameTextField.resignFirstResponder()
        cardExpiryNameTextField.resignFirstResponder()
        securityCodeTextField.resignFirstResponder()
    }
    
    //MARK: -
}

