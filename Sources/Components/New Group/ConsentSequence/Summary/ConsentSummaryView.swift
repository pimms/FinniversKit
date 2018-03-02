//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

// MARK: - ConsentPageViewsDelegate

public protocol ConsentSummaryViewDelegate: NSObjectProtocol {
    func consentSummaryView(_ consentSummaryView: ConsentSummaryView, switchStateDidChange button: Button)
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
        label.textAlignment = .center
        return label
    }()

    private lazy var introDescriptionLabel: Label = {
        let label = Label(style: .body(.stone))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var recommendationLabel: Label = {
        let label = Label(style: .title3)
        return label
    }()

    private lazy var commercialLabel: Label = {
        let label = Label(style: .title3)
        return label
    }()

    private lazy var improveLabel: Label = {
        let label = Label(style: .title3)
        return label
    }()

    private lazy var recommendationsSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.tintColor = .sardine
        mySwitch.onTintColor = .pea
        mySwitch.addTarget(self, action: #selector(recommendationsSwitchChangedState), for: .valueChanged)
        return mySwitch
    }()

    private lazy var commercialSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.tintColor = .sardine
        mySwitch.onTintColor = .pea
        mySwitch.addTarget(self, action: #selector(commercialSwitchChangedState), for: .valueChanged)
        return mySwitch
    }()

    private lazy var improveSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.tintColor = .sardine
        mySwitch.onTintColor = .pea
        mySwitch.addTarget(self, action: #selector(improveSwitchChangedState), for: .valueChanged)
        return mySwitch
    }()

    private lazy var recommendationStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [recommendationLabel, recommendationsSwitch])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = .mediumLargeSpacing
        return view
    }()

    private lazy var commercialStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [commercialLabel, commercialSwitch])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = .mediumLargeSpacing
        return view
    }()

    private lazy var improveStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [improveLabel, improveSwitch])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = .mediumLargeSpacing
        return view
    }()

    private lazy var switchStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [recommendationStackView, commercialStackView, improveStackView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = .largeSpacing
        return view
    }()

    private lazy var descriptionLabel: Label = {
        let label = Label(style: .body(.licorice))
        label.numberOfLines = 0
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(frameworkImageNamed: "consentViewImage1")
        return imageView
    }()

    private lazy var descriptionStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [descriptionLabel, imageView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = .mediumSpacing
        return view
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
            recommendationLabel.text = model.recommendationTitle
            commercialLabel.text = model.commercialTitle
            improveLabel.text = model.improveTitle
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
        contentView.addSubview(switchStackView)
        contentView.addSubview(descriptionStackView)
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

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .largeSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),

            introDescriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .mediumSpacing),
            introDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            introDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),

            switchStackView.topAnchor.constraint(equalTo: introDescriptionLabel.bottomAnchor, constant: .largeSpacing),
            switchStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            switchStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),

            descriptionStackView.topAnchor.constraint(equalTo: switchStackView.bottomAnchor, constant: .largeSpacing),
            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            descriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            descriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.largeSpacing),
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .veryLargeSpacing),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.veryLargeSpacing),
        ])
    }

    // MARK: - Private actions

    @objc private func doneButtonTapped(button: Button) {
    }

    @objc private func recommendationsSwitchChangedState(sender: UISwitch) {
        if sender.isOn {
            print("Recommendations switch is on")
        } else {
            print("Recommendations switch is off")
        }
    }

    @objc private func commercialSwitchChangedState(sender: UISwitch) {
        if sender.isOn {
            print("Commercial switch is on")
        } else {
            print("Commercial switch is off")
        }
    }

    @objc private func improveSwitchChangedState(sender: UISwitch) {
        if sender.isOn {
            print("Improve FINN switch is on")
        } else {
            print("Improve FINN switch is off")
        }
    }
}
