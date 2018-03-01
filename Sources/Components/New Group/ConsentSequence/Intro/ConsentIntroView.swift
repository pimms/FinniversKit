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

    private let noImage: UIImage = UIImage(frameworkImageNamed: "NoImage")!

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
        imageView.image = UIImage(frameworkImageNamed: "consentViewImage1")
        return imageView
    }()

    private lazy var descriptionTitleLabel: Label = {
        let label = Label(style: .title2)
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
            descriptionTitleLabel.text = model.descriptionTitle
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(skipButton)
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionTitleLabel)
        addSubview(continueButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -.mediumSpacing),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            skipButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .mediumSpacing),
            skipButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            skipButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),

            imageView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: .mediumSpacing),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),

            descriptionTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .mediumLargeSpacing),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            descriptionTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.largeSpacing),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .veryLargeSpacing),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.veryLargeSpacing),
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
