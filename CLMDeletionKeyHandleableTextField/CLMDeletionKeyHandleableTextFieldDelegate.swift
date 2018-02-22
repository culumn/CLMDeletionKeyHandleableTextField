//
//  CLMDeletionKeyHandleableTextFieldDelegate.swift
//  CLMDeletionKeyHandleableTextField
//
//  Created by Matsuoka Yoshiteru on 2018/02/22.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

@objc public protocol CLMDeletionKeyHandleableTextFieldDelegate: class, UITextFieldDelegate {
    @objc optional func didDeleteBackward(_ textField: CLMDeletionKeyHandleableTextField)
}
