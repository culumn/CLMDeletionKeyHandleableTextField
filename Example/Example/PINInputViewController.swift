//
//  ViewController.swift
//  Example
//
//  Created by Matsuoka Yoshiteru on 2018/02/22.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit
import CLMDeletionKeyHandleableTextField

// MARK: - Lifecycle
final class PINInputViewController: UIViewController {

    // text fields
    @IBOutlet weak var firstTextField: CLMDeletionKeyHandleableTextField!
    @IBOutlet weak var secondTextField: CLMDeletionKeyHandleableTextField!
    @IBOutlet weak var thirdTextField: CLMDeletionKeyHandleableTextField!
    @IBOutlet weak var fourthTextField: CLMDeletionKeyHandleableTextField!

    lazy var textFields: [CLMDeletionKeyHandleableTextField] = [firstTextField,
                                                                secondTextField,
                                                                thirdTextField,
                                                                fourthTextField]

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        focus(on: firstTextField)
    }
}

// MARK: - Private function
extension PINInputViewController {

    private func configure() {
        for textField in textFields {
            textField.deletionDelegate = self
            textField.addTarget(self, action: #selector(textFieldDidChangeText(_:)), for: .editingChanged)
        }
    }

    private func focus(on textField: CLMDeletionKeyHandleableTextField) {
        textField.isEnabled = true
        textField.becomeFirstResponder()

        for clmTextField in textFields where clmTextField !== textField {
            clmTextField.isEnabled = false
        }
    }

    @objc private func textFieldDidChangeText(_ textField: UITextField) {
        switch textField {
        case firstTextField where firstTextField.isFirstResponder:
            focus(on: secondTextField)
        case secondTextField where secondTextField.isFirstResponder:
            focus(on: thirdTextField)
        case thirdTextField where thirdTextField.isFirstResponder:
            focus(on: fourthTextField)
        case fourthTextField where fourthTextField.isFirstResponder:
            fourthTextField.resignFirstResponder()
        default:
            break
        }
    }
}

// MARK: - CLMDeletionKeyHandleableTextFieldDelegate
extension PINInputViewController: CLMDeletionKeyHandleableTextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }

        guard let text = textField.text,
            text.isEmpty &&
            string.count == 1 &&
            string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        else { return false }

        return true
    }

    func didDeleteBackward(_ textField: CLMDeletionKeyHandleableTextField) {
        switch textField {
        case firstTextField:
            firstTextField.resignFirstResponder()
        case secondTextField:
            firstTextField.text = ""
            focus(on: firstTextField)
        case thirdTextField:
            secondTextField.text = ""
            focus(on: secondTextField)
        case fourthTextField:
            thirdTextField.text = ""
            focus(on: thirdTextField)
        default:
            break
        }
    }
}
