//
//  WishlistTableViewCell.swift
//  FinniversKit
//
//  Created by Stien, Joakim on 08/02/2019.
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

protocol WishlistListViewCellDelegate: class {
    func wishlistCell(_ cell: WishlistListViewCell, imageForModel model: WishlistListViewModel, completion: @escaping (WishlistListViewModel, UIImage?) -> Void)
}

public class WishlistListViewCell: UITableViewCell {

    // MARK: - Private static properties

    static let imageCornerRadius: CGFloat = 3.0
    static let imageHeight: CGFloat = 220.0

    // MARK: - Public properties
    var loadingColor: UIColor = .clear
    var delegate: WishlistListViewCellDelegate?

    // MARK: - Private properties

    private lazy var defaultImage: UIImage? = {
        return UIImage(named: .noImage)
    }()

    private lazy var adImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = WishlistListViewCell.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.image = defaultImage
        return imageView
    }()

    private lazy var imageDescriptionView: UIView = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        view.alpha = 1.0
        view.layer.cornerRadius = WishlistListViewCell.imageCornerRadius
        view.layer.masksToBounds = true

        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        }

        return view
    }()

    private lazy var priceLabel: Label = {
        let label = Label(style: .title4)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    private lazy var activeLabelContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10.0
        return view
    }()

    private lazy var activeLabel: Label = {
        let label = Label(style: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var publishDateLabel: Label = {
        let label = Label(style: .detail)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationLabel: Label = {
        let label = Label(style: .detail)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    private lazy var titleLabel: Label = {
        let label = Label(style: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        isAccessibilityElement = true
        backgroundColor = .milk
        selectionStyle = .none

        contentView.addSubview(adImageView)
        contentView.addSubview(publishDateLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(titleLabel)

        adImageView.addSubview(activeLabelContainerView)
        activeLabelContainerView.addSubview(activeLabel)

        adImageView.addSubview(imageDescriptionView)
        imageDescriptionView.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            adImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            adImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .mediumLargeSpacing),
            adImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            adImageView.heightAnchor.constraint(equalToConstant: WishlistListViewCell.imageHeight),

            publishDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            publishDateLabel.topAnchor.constraint(equalTo: adImageView.bottomAnchor, constant: .mediumSpacing),

            locationLabel.topAnchor.constraint(equalTo: adImageView.bottomAnchor, constant: .mediumSpacing),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            titleLabel.topAnchor.constraint(equalTo: publishDateLabel.bottomAnchor, constant: .mediumSpacing),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumLargeSpacing),

            activeLabelContainerView.trailingAnchor.constraint(equalTo: adImageView.trailingAnchor, constant: -.smallSpacing),
            activeLabelContainerView.bottomAnchor.constraint(equalTo: adImageView.bottomAnchor, constant: -.smallSpacing),

            activeLabel.leadingAnchor.constraint(equalTo: activeLabelContainerView.leadingAnchor, constant: .mediumLargeSpacing),
            activeLabel.topAnchor.constraint(equalTo: activeLabelContainerView.topAnchor, constant: .smallSpacing),
            activeLabel.trailingAnchor.constraint(equalTo: activeLabelContainerView.trailingAnchor, constant: -.mediumLargeSpacing),
            activeLabel.bottomAnchor.constraint(equalTo: activeLabelContainerView.bottomAnchor, constant: -.smallSpacing),

            imageDescriptionView.leadingAnchor.constraint(equalTo: adImageView.leadingAnchor),
            imageDescriptionView.bottomAnchor.constraint(equalTo: adImageView.bottomAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: imageDescriptionView.leadingAnchor, constant: .mediumSpacing),
            priceLabel.topAnchor.constraint(equalTo: imageDescriptionView.topAnchor, constant: .smallSpacing),
            priceLabel.trailingAnchor.constraint(equalTo: imageDescriptionView.trailingAnchor, constant: -.mediumSpacing),
            priceLabel.bottomAnchor.constraint(equalTo: imageDescriptionView.bottomAnchor, constant: -.smallSpacing),
        ])
    }

    // MARK: - Public properties

    public var model: WishlistListViewModel? {
        didSet {
            loadImage()

            accessibilityLabel = model?.accessibilityLabel
            titleLabel.text = model?.title
            publishDateLabel.text = "4 dager"
            locationLabel.text = model?.location
            priceLabel.text = {
                if let price = model?.price {
                    return "\(price.formattedWithSeparator),-"
                } else {
                    return "Gis bort"
                }
            }()

            let isActive = model?.isActive ?? true
            if isActive {
                activeLabelContainerView.backgroundColor = .mint
                activeLabel.text = "Aktiv"
            } else {
                activeLabelContainerView.backgroundColor = .salmon
                activeLabel.text = "Inaktiv"
            }
        }
    }

    // MARK: - Overridden methods

    override public func prepareForReuse() {
        super.prepareForReuse()

        adImageView.image = self.defaultImage
        adImageView.backgroundColor = .toothPaste
        accessibilityLabel = nil
        titleLabel.text = nil
        publishDateLabel.text = nil
        locationLabel.text = nil
        priceLabel.text = nil
    }

    // MARK: - Private methods

    private func loadImage() {
        guard model?.imageUrl != nil,
              let delegate = delegate,
              let model = model else {
            adImageView.image = defaultImage
            adImageView.backgroundColor = .toothPaste
            return
        }

        adImageView.backgroundColor = loadingColor

        delegate.wishlistCell(self, imageForModel: model, completion: { [weak self] (sourceModel, image) in
            guard self?.model?.adId == sourceModel.adId else {
                print("ain't me yo")
                return
            }

            if let image = image {
                self?.adImageView.image = image
                self?.adImageView.backgroundColor = .clear
            } else {
                self?.adImageView.image = self?.defaultImage
                self?.adImageView.backgroundColor = .toothPaste
            }
        })
    }
}
