//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

// MARK: - ConsentPageViewsDelegate

public protocol ConsentSummaryViewDelegate: NSObjectProtocol {
    func consentSummaryView(_ consentSummaryView: ConsentSummaryView, switchStateDidChange switch: UISwitch)
    func consentSummaryView(_ consentSummaryView: ConsentSummaryView, didSelectDoneButton button: Button)
}

public class ConsentSummaryView: UIView {

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

    private lazy var titleLabel: Label = {
        let label = Label(style: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var introDescriptionLabel: Label = {
        let label = Label(style: .body(.stone))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(frameworkImageNamed: "consentSummaryImage")
        return imageView
    }()

    private lazy var recommendationToggleSwitchView: ToggleSwitchView = {
        return setupToggleSwitchView()
    }()

    private lazy var commercialToggleSwitchView: ToggleSwitchView = {
        return setupToggleSwitchView()
    }()

    private lazy var improveToggleSwitchView: ToggleSwitchView = {
        return setupToggleSwitchView()
    }()

    private lazy var descriptionLabel: Label = {
        let label = Label(style: .body(.stone))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var doneButton: Button = {
        let button = Button(style: .callToAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - External properties / Dependency injection

    public weak var delegate: ConsentSummaryViewDelegate?

    public var model: ConsentSummaryViewModel? {
        didSet {
            guard let model = model else {
                return
            }

            titleLabel.text = model.title
            introDescriptionLabel.text = model.introDescription
            recommendationToggleSwitchView.model = model.recommendationModel
            recommendationToggleSwitchView.setOn(true)

            commercialToggleSwitchView.model = model.commercialModel
            improveToggleSwitchView.model = model.improveModel
            descriptionLabel.text = model.description
            doneButton.setTitle(model.doneButtonTitle, for: .normal)
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

        contentView.addSubview(titleLabel)
        contentView.addSubview(introDescriptionLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(recommendationToggleSwitchView)
        contentView.addSubview(commercialToggleSwitchView)
        contentView.addSubview(improveToggleSwitchView)
        contentView.addSubview(descriptionLabel)
        addSubview(doneButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -.mediumSpacing),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .veryLargeSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor, constant: -.mediumSpacing),

            introDescriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .mediumSpacing),
            introDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            introDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor, constant: -.mediumSpacing),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .mediumLargeSpacing),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),

            recommendationToggleSwitchView.topAnchor.constraint(equalTo: introDescriptionLabel.bottomAnchor, constant: .largeSpacing),
            recommendationToggleSwitchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            recommendationToggleSwitchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),

            commercialToggleSwitchView.topAnchor.constraint(equalTo: recommendationToggleSwitchView.bottomAnchor, constant: .mediumLargeSpacing),
            commercialToggleSwitchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            commercialToggleSwitchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),

            improveToggleSwitchView.topAnchor.constraint(equalTo: commercialToggleSwitchView.bottomAnchor, constant: .mediumLargeSpacing),
            improveToggleSwitchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            improveToggleSwitchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),

            descriptionLabel.topAnchor.constraint(equalTo: improveToggleSwitchView.bottomAnchor, constant: .largeSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.largeSpacing),
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .veryLargeSpacing),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.veryLargeSpacing),
        ])
    }

    // MARK: - Private actions

    @objc private func doneButtonTapped(button: Button) {
        delegate?.consentSummaryView(self, didSelectDoneButton: button)
    }

    private func setupToggleSwitchView() -> ToggleSwitchView {
        let view = ToggleSwitchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

// MARK: - ToggleSwitchDelegate

extension ConsentSummaryView: ToggleSwitchDelegate {
    public func toggleSwitch(_ toggleSwitchView: ToggleSwitchView, didChangeValueFor toggleSwitch: UISwitch) {
        delegate?.consentSummaryView(self, switchStateDidChange: toggleSwitch)
    }
}
