//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

// MARK: - ConsentPageViewsDelegate

public protocol ConsentIntroViewDelegate: NSObjectProtocol {
    func consentIntroView(_ consentIntroView: ConsentIntroView, didSelectContinueButton button: Button)
    func consentIntroView(_ consentIntroView: ConsentIntroView, didSelectSkipButton button: Button)
}

public class ConsentIntroView: UIView {

    // MARK: - Internal properties

    private let minimumImageHeight: CGFloat = 100

    private lazy var continueButton: Button = {
        let button = Button(style: .callToAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var skipButton: Button = {
        let button = Button(style: .flat)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(frameworkImageNamed: "consentIntroImage")
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()

    private lazy var descriptionHeaderLabel: Label = {
        let label = Label(style: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: Label = {
        let label = Label(style: .title4(.licorice))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // MARK: - External properties / Dependency injection

    public weak var delegate: ConsentIntroViewDelegate?

    public var model: ConsentIntroViewModel? {
        didSet {
            guard let model = model else {
                return
            }

            continueButton.setTitle(model.continueButtonTitle, for: .normal)
            skipButton.setTitle(model.skipButtonTitle, for: .normal)
            descriptionHeaderLabel.text = model.descriptionHeaderTitle
            descriptionLabel.text = model.descriptionTitle
        }
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
        addSubview(skipButton)
        addSubview(imageView)
        addSubview(descriptionHeaderLabel)
        addSubview(descriptionLabel)
        addSubview(continueButton)

        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: .mediumLargeSpacing),
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.mediumLargeSpacing),
            skipButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: .mediumLargeSpacing),

            imageView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: .mediumLargeSpacing),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.mediumLargeSpacing),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: descriptionHeaderLabel.topAnchor, constant: -.largeSpacing),
            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumImageHeight),

            descriptionHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing),
            descriptionHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.mediumLargeSpacing),
            descriptionHeaderLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -.largeSpacing),

            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.mediumLargeSpacing),
            descriptionLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -.veryLargeSpacing),

            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .veryLargeSpacing),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.veryLargeSpacing),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.veryLargeSpacing),
        ])
    }

    // MARK: - Private actions

    @objc private func continueButtonTapped(button: Button) {
        delegate?.consentIntroView(self, didSelectContinueButton: button)
    }

    @objc private func skipButtonTapped(button: Button) {
        delegate?.consentIntroView(self, didSelectSkipButton: button)
    }
}
