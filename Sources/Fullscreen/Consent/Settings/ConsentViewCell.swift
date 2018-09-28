//
//  Copyright © 2018 FINN AS. All rights reserved.
//
import UIKit

public struct ConsentViewCellModel {

    public let title: String
    public var stateText: String?
    public let hairLine: Bool

    public init(title: String, stateText: String? = nil, hairLine: Bool = true) {
        self.title = title
        self.stateText = stateText
        self.hairLine = hairLine
    }
}

public class ConsentViewCell: UITableViewCell {
    public static var reuseIdentifier = "consent-cell"

    private lazy var titleLabel: UILabel = {
        let label = Label(style: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stateLabel: UILabel = {
        let label = Label(style: .body)
        label.textColor = .stone
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var arrowView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: .arrowRight).withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .sardine
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var hairLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = .sardine
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    public var model: ConsentViewCellModel? {
        didSet { set(model: model) }
    }

    public var labelInset: CGFloat = 14

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSubviews()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConsentViewCell {

    func set(model: ConsentViewCellModel?) {
        guard let model = model else { return }
        titleLabel.text = model.title
        stateLabel.text = model.stateText

        guard !model.hairLine else { return }
        hairLine.removeFromSuperview()
    }

    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(stateLabel)
        contentView.addSubview(arrowView)
        contentView.addSubview(hairLine)

        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelInset),
            titleLabel.trailingAnchor.constraint(equalTo: stateLabel.leadingAnchor, constant: -.smallSpacing),

            stateLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -.mediumLargeSpacing),
            stateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            arrowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            arrowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            hairLine.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            hairLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hairLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hairLine.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale),

            contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: labelInset)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
