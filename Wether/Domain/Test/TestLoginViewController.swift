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

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var invalidEmailLabel: UILabel!
    @IBOutlet private weak var invalidPasswordLable: UILabel!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    private var keyboardVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let validEmail = emailTextField.rx
            .text.orEmpty
            .map { text -> Bool in
                let regExp = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
                    "\\@" +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                    "(" +
                    "\\." +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                ")+"
                let predicate = NSPredicate(format: "SELF MATCHES %@", regExp)
                return predicate.evaluate(with: text)
            }
            .share(replay: 1)// without this map would be executed once for each binding, rx is stateless by default
        
        let validPassword = passwordTextField.rx
            .text.orEmpty
            .map { text in
                text.count > 8
            }
            .share(replay: 1)
        
        let validFields = Observable.combineLatest(validEmail, validPassword) {
            $0 && $1
        }.share(replay: 1)
        
        
        validEmail.bind(to: invalidEmailLabel.rx.isHidden).disposed(by: disposeBag)
        validPassword.bind(to: invalidPasswordLable.rx.isHidden).disposed(by: disposeBag)
        validEmail.bind(to: passwordTextField.rx.isEnabled).disposed(by: disposeBag)
        validFields.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
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
