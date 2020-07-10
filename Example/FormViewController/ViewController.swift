//
//  ViewController.swift
//  FormViewController
//
//  Created by jke661s@gmail.com on 07/10/2020.
//  Copyright (c) 2020 jke661s@gmail.com. All rights reserved.
//

import UIKit
import FormViewController

class ViewController: FormViewController {
    
    // MARK: UI Elements
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "startup"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let logoLabel = UILabel(text: "FullStack Social", font: .systemFont(ofSize: 32, weight: .heavy), numberOfLines: 0)
    
    let emailTextField = IndentedTextField(placeholder: "Email", padding: 24, cornerRadius: 25, keyboardType: .emailAddress, backgroundColor: .white)
    
    let passwordTextField = IndentedTextField(placeholder: "Password", padding: 24, cornerRadius: 25, backgroundColor: .white, isSecureTextEntry: true)
    
    lazy var loginButton = UIButton(title: "Login", titleColor: .white, font: .boldSystemFont(ofSize: 18), backgroundColor: .black, target: self, action: #selector(handleLogin))
    
    let errorLabel = UILabel(text: "Your login credentials were incorrect, please try again.", font: .systemFont(ofSize: 14), textColor: .red, textAlignment: .center, numberOfLines: 0)
    
    lazy var goToRegisterButton = UIButton(title: "Need an account? Go to register.", titleColor: .black, font: .systemFont(ofSize: 16), target: self, action: #selector(handleGoToRegister))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .init(white: 0.95, alpha: 1)
        
        emailTextField.autocapitalizationType = .none
        navigationController?.navigationBar.isHidden = true
        errorLabel.isHidden = true
        
        logoImageView.setSize(size: .init(width: 80, height: 80))
        logoLabel.setWidth(width: 160)
        [emailTextField, passwordTextField, loginButton].forEach { view in
            view.setHeight(height: 50)
        }
        loginButton.layer.cornerRadius = 25
        
        let logoInnerStackView = UIStackView(arrangedSubviews: [logoImageView, logoLabel])
        logoInnerStackView.spacing = 15
        
        let logoStackView = UIStackView(arrangedSubviews: [logoInnerStackView])
        logoStackView.alignment = .center
        logoStackView.axis = .vertical
        logoStackView.isLayoutMarginsRelativeArrangement = true
        logoStackView.layoutMargins = .init(top: 0, left: 0, bottom: 14, right: 0)
        
        let formStackView = UIStackView(arrangedSubviews: [logoStackView, emailTextField, passwordTextField, loginButton, errorLabel, goToRegisterButton])
        formStackView.axis = .vertical
        formStackView.spacing = 12
        
        containerView.addSubview(formStackView)
        setupSpaceAboveKeyboard(distance: 10)
        formStackView.fillSuperView(padding: .init(top: 600, left: 32, bottom: 0, right: -32))
    }
    
    @objc fileprivate func handleLogin() {
        // handle login here
        print("login")
    }
    
    @objc fileprivate func handleGoToRegister() {
        // handle go to register here
        print("go to register")
    }
    
}

class IndentedTextField: UITextField {
    
    let padding: CGFloat
    
    init(placeholder: String? = nil, padding: CGFloat = 0, cornerRadius: CGFloat = 0, keyboardType: UIKeyboardType = .default, backgroundColor: UIColor = .clear, isSecureTextEntry: Bool = false) {
        self.padding = padding
        super.init(frame: .zero)
        self.placeholder = placeholder
        layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UILabel {
    
    convenience init(text: String? = nil, font: UIFont? = .systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    
}

extension UIButton {
    
    convenience init(title: String, titleColor: UIColor, font: UIFont = .systemFont(ofSize: 14), backgroundColor: UIColor = .clear, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    convenience init(image: UIImage, tintColor: UIColor? = nil, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        if tintColor == nil {
            setImage(image, for: .normal)
        } else {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = tintColor
        }
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func setSize(size: CGSize) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        [anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        return anchoredConstraints
    }
    
    @discardableResult
    func setWidth(width: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let widthAnchor = self.widthAnchor.constraint(equalToConstant: width)
        widthAnchor.isActive = true
        return widthAnchor
    }
    
    @discardableResult
    func setHeight(height: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let heightAnchor = self.heightAnchor.constraint(equalToConstant: height)
        heightAnchor.isActive = true
        return heightAnchor
    }
    
    @discardableResult
    func fillSuperView(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return anchoredConstraints
        }
        
        return setConstraint(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    @discardableResult
    func setConstraint(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func top(to topOrBottomAnchor: NSLayoutYAxisAnchor, offset: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: topOrBottomAnchor, constant: CGFloat(offset)).isActive = true
    }
    
    func bottom(to topOrBottomAnchor: NSLayoutYAxisAnchor, offset: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: topOrBottomAnchor, constant: CGFloat(offset)).isActive = true
    }
    
    func leading(to leadingOrTrailingAnchor: NSLayoutXAxisAnchor, offset: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: leadingOrTrailingAnchor, constant: CGFloat(offset)).isActive = true
    }
    
    func trailing(to leadingOrTrailingAnchor: NSLayoutXAxisAnchor, offset: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: leadingOrTrailingAnchor, constant: CGFloat(offset)).isActive = true
    }
    
    func center(to view: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func centerX(to view: UIView, offset: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(to view: UIView, offset: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
