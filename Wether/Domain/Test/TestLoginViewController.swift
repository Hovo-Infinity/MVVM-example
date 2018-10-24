//
//  TestLoginViewController.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/22/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestLoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    private var viewModel: TestLoginViewModel?

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var invalidEmailLabel: UILabel!
    @IBOutlet private weak var invalidPasswordLable: UILabel!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    private var keyboardVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TestLoginViewModel(email: emailTextField.rx.text, password: passwordTextField.rx.text, disposeBag: disposeBag)
        bindViews()
        // Do any additional setup after loading the view.
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(keyboardDidOpen(_:)),
                         name: UIApplication.keyboardDidShowNotification,
                         object: nil)
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(keyboardWillHide(_:)),
                         name: UIApplication.keyboardWillHideNotification,
                         object: nil)
    }
    
    private func bindViews() {
        viewModel?.validEmail.bind(to: invalidEmailLabel.rx.isHidden).disposed(by: disposeBag)
        viewModel?.validPassword.bind(to: invalidPasswordLable.rx.isHidden).disposed(by: disposeBag)
        viewModel?.validEmail.bind(to: passwordTextField.rx.isEnabled).disposed(by: disposeBag)
        viewModel?.validFields.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
    }
    
    @IBAction private func loginButtonTapped() {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        let navigationController = UINavigationController(rootViewController: nextVC)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
    @objc
    private func keyboardDidOpen(_ notification: Notification) {
        if !keyboardVisible {
            guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame = keyboardFrameValue.cgRectValue
            scrollView.contentSize.height += (keyboardFrame.height - 60.0)
            keyboardVisible = true
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        if keyboardVisible {
            guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame = keyboardFrameValue.cgRectValue
            scrollView.contentSize.height -= (keyboardFrame.height - 60.0)
            keyboardVisible = false
        }
    }

}

extension TestLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
