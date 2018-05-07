//
//  CardholderNameValidator.swift
//  goSellSDK
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Cardholder name validator.
internal class CardholderNameValidator: CardValidator {
    
    // MARK: - Internal -
    // MARK: Properties
    
    internal var cardholderName: String {
        
        return self.textField.attributedText?.string ?? .empty
    }
    
    internal override var isValid: Bool {
        
        return self.cardholderName.isValidCardholderName
    }
    
    // MARK: Methods
    
    internal init(textField: UITextField) {
        
        self.textField = textField
        super.init(validationType: .nameOnCard)
        
        self.setupTextField()
    }
    
    // MARK: - Private -
    
    private struct Constants {
        
        fileprivate static let maximalCardholderNameLength = 26
        fileprivate static let validCharactersRange = Constants.lowerBound...Constants.upperBound
        
        private static let lowerBound = "20".fromHex
        private static let upperBound = "5F".fromHex
        
        @available(*, unavailable) private init() {}
    }
    
    // MARK: Properties
    
    private unowned let textField: UITextField
    
    private lazy var textFieldDelegate: CardholderNameTextFieldDelegate = CardholderNameTextFieldDelegate(validator: self)
    
    // MARK: Methods
    
    private func setupTextField() {
        
        self.textField.keyboardAppearance = Theme.current.settings.keyboardStyle
        self.textField.delegate = self.textFieldDelegate
        self.textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldEditingChanged(_ sender: Any) {
        
        self.validate()
    }
}

// MARK: - TextInputDataValidation
extension CardholderNameValidator: TextInputDataValidation {
    
    internal var textInputField: UITextField {
        
        return self.textField
    }
    
    internal var textInputFieldText: String {
        
        return self.cardholderName
    }
    
    internal var textInputFieldPlaceholderText: String {
        
        return "Name on Card"
    }
    
    internal func updateSpecificInputFieldAttributes() { }
}

// MARK: - CardholderNameTextFieldDelegate
fileprivate extension CardholderNameValidator {
    
    fileprivate class CardholderNameTextFieldDelegate: NSObject {
        
        fileprivate init(validator: CardholderNameValidator) {
            
            self.validator = validator
            super.init()
        }
        
        private unowned let validator: CardholderNameValidator
    }
}

// MARK: - UITextFieldDelegate
extension CardholderNameValidator.CardholderNameTextFieldDelegate: UITextFieldDelegate {
    
    fileprivate func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let resultString = (textField.attributedText?.string ?? String.empty).replacing(range: range, withString: string).uppercased()
        
        var valid = true
        for character in resultString {
            
            if !CardholderNameValidator.Constants.validCharactersRange.contains(character) {
                
                valid = false
                break
            }
        }
        
        let canReplace = valid && resultString.length <= CardholderNameValidator.Constants.maximalCardholderNameLength
        
        if canReplace {
            
            textField.attributedText = NSAttributedString(string: resultString, attributes: Theme.current.settings.cardInputFieldsSettings.valid.asStringAttributes)
            
            if let rangeStart = textField.position(from: textField.beginningOfDocument, offset: range.location + string.length),
               let rangeEnd = textField.position(from: rangeStart, offset: 0) {
                
                textField.selectedTextRange = textField.textRange(from: rangeStart, to: rangeEnd)
            }
        }
        
        return false
    }
    
    fileprivate func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.validator.updateInputFieldAttributes()
        self.validator.validate()
    }
    
    fileprivate func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.validator.updateInputFieldAttributes()
        self.validator.validate()
    }
}

// MARK: - String + Hex
fileprivate extension String {
    
    fileprivate var fromHex: Character {
        
        return Character(UnicodeScalar(Int(strtoul(self, nil, 16)))!)
    }
}
