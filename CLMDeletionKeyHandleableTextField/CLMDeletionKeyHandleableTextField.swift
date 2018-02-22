//
//  CLMDeletionKeyHandleableTextField.swift
//  CLMDeletionKeyHandleableTextField
//
//  Created by Matsuoka Yoshiteru on 2018/02/22.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

public class CLMDeletionKeyHandleableTextField: UITextField {

    public weak var deletionDelegate: CLMDeletionKeyHandleableTextFieldDelegate? {
        didSet {
            delegate = deletionDelegate
        }
    }

    override public func deleteBackward() {
        super.deleteBackward()
        deletionDelegate?.didDeleteBackward?(self)
    }
}
