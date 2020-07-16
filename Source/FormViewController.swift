//
//  FormViewController.swift
//  social_ios
//
//  Created by Jackie Wang on 10/7/20.
//  Copyright © 2020 Jackie Wang. All rights reserved.
//

import UIKit

open class FormViewController: UIViewController {
    
    fileprivate let scrollView = UIScrollView()
    fileprivate var activeTextField: UITextField?
    fileprivate var distance: CGFloat = 0
    public var containerView = UIView()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupKeyboardNotification()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if containerView.frame.height > view.frame.height {
            scrollView.contentSize.height = containerView.frame.height
        }
    }
    
    public func setupSpaceAboveKeyboard(distance: CGFloat) {
        self.distance = distance
    }
    
    fileprivate func setupLayout() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .onDrag
        scrollView.contentSize = view.frame.size
        scrollView.addSubview(containerView)
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardChange(notification: NSNotification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomInset = keyboardFrame.height + distance
        scrollView.contentInset.bottom = bottomInset
        scrollView.scrollIndicatorInsets.bottom = bottomInset
        guard let activeTextField = activeTextField else { return }
        let visibleRect = activeTextField.convert(activeTextField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(visibleRect, animated: true)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension FormViewController: UITextFieldDelegate {
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
}
