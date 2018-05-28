//
//  FormTableViewCell.swift
//  TableForm
//
//  Created by Deepak Kumar on 16/05/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import UIKit

protocol FormTableViewCellDelegate: class {
    func valueDidChanged(_ formData: FormDataSource, value: String)
}

extension FormTableViewCellDelegate {
    func valueDidChanged(_ formData: FormDataSource, value: String) {
        
    }
}

class FormTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var formLabel: UILabel!
    @IBOutlet weak var formImageView: UIImageView!
    @IBOutlet weak var formTextField: UITextField!
    
    
    var formData: FormDataSource? {
        didSet {
            if let formData = self.formData {
                configureCell(formData)
            }
        }
    }
    
    weak var delegate: FormTableViewCellDelegate?
    var valueChaged: ((FormDataSource, String)-> Void)?

    
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        formTextField.delegate = self
        formTextField.addTarget(self, action: #selector(valueChanged(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ formData: FormDataSource) {
        formLabel.text = ""//formData.title
        
        formTextField.placeholder = formData.placeHolder
        formTextField.text = formData.value
        formTextField.keyboardType = formData.keyboardType
        formTextField.returnKeyType = formData.returnKey
        formTextField.isSecureTextEntry = formData.secureTextEntry
        
        formImageView.image = formData.iconImage
    }
    
    @objc func valueChanged(_ textField: UITextField) {
        //print(textField.text!)
        if let delegate = self.delegate, let value = textField.text, let formData = self.formData {
            delegate.valueDidChanged(formData, value: value)
        }
    }
    
}

// MARK: - Extension
extension FormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        switch textField {
//        case textField:
//            formTextField.resignFirstResponder()
//        default:
//            self.resignFirstResponder()
//        }
        
//        if textField.tag == 0 {
//            textField.viewWithTag(1)?.becomeFirstResponder()
//        }else {
//            self.resignFirstResponder()
//        }
        
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
        //return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case formTextField:
            formLabel.text = formData?.title
            formTextField.placeholder = nil
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case formTextField:
            formLabel.text = nil
            formTextField.placeholder = formData?.placeHolder
        default:
            break
        }
    }
}
