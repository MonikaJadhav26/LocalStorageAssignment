//
//  UVTextField.swift
//  Univibe
//
//  Created by Vipul on 15/11/16.
//  Copyright © 2016 Vipul. All rights reserved.
//

import UIKit


@objc protocol UVCustomViewTextFieldDelegate {
    
    func textFieldTextDidChange(textField:UITextField)
    
    @objc optional func doneButtonTapped(sender : UIBarButtonItem , datePicker : UIDatePicker , textField : UITextField,date: String)
    
    @objc optional func doneButtonTappedForPickerView(sender : UIBarButtonItem , pickerView : UIPickerView , textField : UITextField, pickerValue: String)
    
    @objc optional func pickerValueDidChange(pickerValue : String, textField:UITextField)
    
    
}

class UVBorderView: UIView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        border()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        border()
        
    }
    
    func border(){
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
    }
}

class UVCustomView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var customViewTextFieldDelegate:UVCustomViewTextFieldDelegate?
    var isAccessesaryViewRequired : Int = 0
    var textLimit = 200000
    var pickerOption = [String]()
    var pickerView = UIPickerView()
    var isOnlyTextAllowed = false
    
    //Follwing variable must be set when you crate an object of this class.
    var bottomViewContraint:NSLayoutConstraint?
    var parentController:UIViewController?
    var scrollContentHeightViewContraint:NSLayoutConstraint?
    var scrollView: UIScrollView?
    
    
    @IBInspectable var titleText: String? {
        didSet {
            
            titleLabel.text = titleText
        }
    }
    
    @IBInspectable var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
            
        }
    }
    
    @IBInspectable var accessesaryView: Int = 0 {
        didSet {
            
            if accessesaryView == 1 {
                //Picker View
                addPickerViewToTextfiled()
                addToolBarOnTextView()
            }
            
        }
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //nib view setup
        nibViewSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK: - Nib File Setup Methods
    private func nibViewSetup() {
        backgroundColor = UIColor.white
        //load nib
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        layer.cornerRadius = 4.0
        
        textField.addTarget(self, action: #selector(UVCustomView.textFieldTextdidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    
    func addNotificationForKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(UVCustomView.willShowKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UVCustomView.willHideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    //MARK: - Notification handler when keyboard will show
    @objc private func willShowKeyboard(notification:Notification){
        
        if accessesaryView == 2 {
            textField.resignFirstResponder()
        }else {
            let infoDict = notification.userInfo
            
            let keyboardHeight = getKeyboardHeight(infoDict: infoDict!)
            
            if UIDevice().name == "iPhone 8" || UIDevice().name == "iPhone 8 Plus" {
                animateKeyboard(height: keyboardHeight - 49)
                
            }else {
                animateKeyboard(height: keyboardHeight - 79)
                
            }
            var contentInset:UIEdgeInsets = self.scrollView?.contentInset ?? .zero
            contentInset.bottom = keyboardHeight
            self.scrollView?.contentInset = contentInset
        }
    }
    
    //MARK: - Notification handler when keyboard will hide
    @objc private func willHideKeyboard(notification:Notification){
        animateKeyboard(height: 0)
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInset
    }
    
    private func getKeyboardHeight(infoDict:[AnyHashable:Any]) -> CGFloat{
        
        let userInfo = infoDict as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        return keyboardHeight
        
    }
    
    
    
    //MARK: - Function to animate
    private func animateKeyboard(height:CGFloat){
        guard bottomViewContraint != nil else {
            print("Bottomview contraint value is not set. It is nil")
            return
        }
        
        guard parentController != nil else {
            print("Parent Controller is nil")
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.bottomViewContraint?.constant = height
            self.parentController?.view.layoutIfNeeded()
            
        }, completion:  {_ in
            
        })
    }
    
    @objc private func textFieldTextdidChange(textField:UITextField){
        customViewTextFieldDelegate?.textFieldTextDidChange(textField: textField)
    }
    
    
    
    func addToolBarOnTextView(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(UVCustomView.doneButtonActionMethod(sender:)))
        var tootlbar = UIToolbar()
        tootlbar = getToolBarWith(doneButton: doneButton, controller: nil)
        textField.inputAccessoryView = tootlbar
    }
    
    func getCalenderMaxDate() -> Date {
        let date = NSCalendar.current.date(byAdding: .year, value: -15, to: Date())
        return date!
    }
    
    
    
    @objc func doneButtonActionMethod(sender : UIBarButtonItem)
    {
        if accessesaryView == 1 {
            customViewTextFieldDelegate?.doneButtonTappedForPickerView!(sender: sender, pickerView: pickerView, textField: textField, pickerValue: pickerOption[pickerView.selectedRow(inComponent: 0)] as String)
        }else {
            textField.resignFirstResponder()
        }
    }
    
    
    
    func doneButtonTappedForPickerView(sender : UIBarButtonItem , pickerView : UIPickerView , textField : UITextField, pickerValue: String) {
        customViewTextFieldDelegate?.doneButtonTappedForPickerView!(sender: sender, pickerView: pickerView, textField: textField, pickerValue: pickerValue)
        
    }
    
    func pickerValueDidChange(pickerValue : String, textField:UITextField) {
        customViewTextFieldDelegate?.pickerValueDidChange!(pickerValue: pickerOption[pickerView.selectedRow(inComponent: 0)] as String, textField:textField)
    }
    
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle.main
        let nib = UINib(nibName: String("UVCustomView"), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    
    func addPickerViewToTextfiled()  {
        pickerView.delegate = self
        textField.inputView = pickerView
    }
    
    
    
    //MARK: Toolbar for textfields
    
    func getToolBarWith(doneButton:UIBarButtonItem, controller:UIViewController?) -> UIToolbar{
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: controller, action: nil)
        
        toolBar.items = [flexibleSpace,doneButton]
        toolBar.sizeToFit()
        
        return toolBar
    }
}

extension UVCustomView : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func  numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        customViewTextFieldDelegate?.pickerValueDidChange!(pickerValue: pickerOption[pickerView.selectedRow(inComponent: 0)] as String, textField:textField)
    }
}

extension UVCustomView:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if accessesaryView == 2 {
            customViewTextFieldDelegate?.textFieldTextDidChange(textField: textField)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

