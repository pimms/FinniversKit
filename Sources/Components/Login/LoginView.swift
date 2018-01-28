//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

// MARK: - LoginViewDelegatew

public protocol LoginViewDelegate: NSObjectProtocol {

    func loginView(_ loginView: LoginView, didSelectForgetPasswordButton button: Button)
    func loginView(_ loginView: LoginView, didSelectLoginButton button: Button)
    func loginView(_ loginView: LoginView, didSelectNewUserButton button: Button)
    func loginView(_ loginView: LoginView, didSelectUserTermsButton button: Button)
    func loginView(_ loginView: LoginView, didSelectCustomerServiceButton button: Button)

    func loginView(_ loginView: LoginView, didOccurIncompleteCredentials incompleteCredentials: Bool)
}

public class LoginView: UIView {

    // MARK: - Internal properties

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var infoLabel: Label = {
        let label = Label(style: .body(.licorice))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    fileprivate lazy var emailTextField: TextField = {
        let textField = TextField(inputType: .email)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()

    fileprivate lazy var passwordTextField: TextField = {
        let textField = TextField(inputType: .password)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()

    private lazy var forgotPasswordButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forgotPasswordButtonSelected), for: .touchUpInside)
        return button
    }()

    private lazy var loginButton: Button = {
        let button = Button(style: .callToAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonSelected), for: .touchUpInside)
        return button
    }()

    private lazy var newUserStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [spidLogoImageView, newUserButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 11
        return stackView
    }()

    private lazy var spidLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(frameworkImageNamed: "SpidLogo")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var newUserButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newUserButtonSelected), for: .touchUpInside)
        return button
    }()

    private lazy var userTermsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userTermsIntroLabel, userTermsButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private lazy var userTermsIntroLabel: Label = {
        let label = Label(style: .detail(.licorice))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var userTermsButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(userTermsButtonSelected), for: .touchUpInside)
        return button
    }()

    private lazy var customerServiceButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(customerServiceButtonSelected), for: .touchUpInside)
        return button
    }()

    fileprivate let buttonHeight: CGFloat = 44

    // MARK: - Dependency injection

    public var model: LoginViewModel? {
        didSet {
            guard let model = model else {
                return
            }
            infoLabel.text = model.headerText
            emailTextField.placeholderText = model.emailPlaceholder
            passwordTextField.placeholderText = model.passwordPlaceholder
            forgotPasswordButton.setTitle(model.forgotPasswordButtonTitle, for: .normal)
            loginButton.setTitle(model.loginButtonTitle, for: .normal)
            newUserButton.setTitle(model.newUserButtonTitle, for: .normal)
            userTermsIntroLabel.text = model.userTermsIntroText
            userTermsButton.setTitle(model.userTermsButtonTitle, for: .normal)
            customerServiceButton.setTitle(model.customerServiceTitle, for: .normal)
        }
    }

    // MARK: - External properties

    public weak var delegate: LoginViewDelegate?

    public var email: String {
        guard let email = emailTextField.text else {
            return ""
        }
        return email
    }

    // MARK: - Setup

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)

        loginButton.isEnabled = false

        scrollView.addSubview(contentView)
        addSubview(scrollView)

        contentView.addSubview(infoLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(forgotPasswordButton)
        contentView.addSubview(loginButton)
        contentView.addSubview(newUserStackView)
        contentView.addSubview(userTermsStackView)
        contentView.addSubview(customerServiceButton)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .largeSpacing),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),

            emailTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: .mediumLargeSpacing),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: .largeSpacing),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),

            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: .mediumSpacing),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),

            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: .largeSpacing),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),
            loginButton.heightAnchor.constraint(equalToConstant: buttonHeight),

            newUserStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: .mediumLargeSpacing),
            newUserStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            spidLogoImageView.heightAnchor.constraint(equalToConstant: 15),

            userTermsStackView.topAnchor.constraint(equalTo: newUserStackView.bottomAnchor, constant: .mediumLargeSpacing),
            userTermsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            userTermsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),

            customerServiceButton.topAnchor.constraint(equalTo: userTermsStackView.bottomAnchor, constant: .largeSpacing),
            customerServiceButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            customerServiceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),
            customerServiceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.largeSpacing),
        ])
    }

    // MARK: - Actions

    @objc func loginButtonSelected() {
        delegate?.loginView(self, didSelectLoginButton: loginButton)
    }

    @objc func forgotPasswordButtonSelected() {
        delegate?.loginView(self, didSelectForgetPasswordButton: forgotPasswordButton)
    }

    @objc func newUserButtonSelected() {
        delegate?.loginView(self, didSelectNewUserButton: newUserButton)
    }

    @objc func userTermsButtonSelected() {
        delegate?.loginView(self, didSelectUserTermsButton: userTermsButton)
    }

    @objc func customerServiceButtonSelected() {
        delegate?.loginView(self, didSelectCustomerServiceButton: userTermsButton)
    }

    @objc func handleTap() {
        endEditing(true)
    }
}

// MARK: - TextFieldDelegate

extension LoginView: TextFieldDelegate {

    public func textFieldShouldReturn(_ textField: TextField) -> Bool {
        if textField == emailTextField {
        } else {
            if loginButton.isEnabled {
                loginButtonSelected()
            } else {
                delegate?.loginView(self, didOccurIncompleteCredentials: true)
            }
        }
        return true
    }

    public func textFieldDidChange(_ textField: TextField) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            return
        }

        if emailText.isEmpty || passwordText.isEmpty {
            loginButton.isEnabled = false
        } else {
            loginButton.isEnabled = true
        }
    }
}
