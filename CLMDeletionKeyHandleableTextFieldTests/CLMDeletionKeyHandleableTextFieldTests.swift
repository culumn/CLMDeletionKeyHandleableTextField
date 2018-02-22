//
//  CLMDeletionKeyHandleableTextFieldTests.swift
//  CLMDeletionKeyHandleableTextFieldTests
//
//  Created by Matsuoka Yoshiteru on 2018/02/22.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import CLMDeletionKeyHandleableTextField

class CLMDeletionKeyHandleableTextFieldTests: XCTestCase {

    final class TestViewController: UIViewController, CLMDeletionKeyHandleableTextFieldDelegate {
        let clmTextField = CLMDeletionKeyHandleableTextField()
        var didCallDeletionDelegate = false
        var didCallDelegate = false

        override func viewDidLoad() {
            super.viewDidLoad()

            clmTextField.deletionDelegate = self
        }

        func didDeleteBackward(_ textField: CLMDeletionKeyHandleableTextField) {
            didCallDeletionDelegate = true
        }

        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            didCallDelegate = true
            return true
        }
    }
    
    func testCallDeletionDelegate() {
        let testViewController = TestViewController()
        testViewController.viewDidLoad()
        testViewController.clmTextField.deleteBackward()

        XCTAssertTrue(testViewController.didCallDeletionDelegate, "Did not call deletion delegate")
    }

    func testCallDelegate() {
        let testViewController = TestViewController()
        testViewController.viewDidLoad()
        let textField = testViewController.clmTextField
        textField.deletionDelegate?.textFieldShouldClear?(textField)

        XCTAssertTrue(testViewController.didCallDelegate, "Did not call delegate")
    }
}
