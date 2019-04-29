import Foundation

public class InstaObjectMainImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Public properties

    public weak var imageDownloader: ImageDownloader?

    // MARK: - Private properties

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = UIFont.detailStrong.withSize(32)
        label.numberOfLines = 0
        label.textColor = .licorice
        return label
    }()

    private lazy var titleLabelShadow: UIVisualEffectView = {
        let effectView = UIVisualEffectView(withAutoLayout: true)
        effectView.effect = UIBlurEffect(style: .prominent)
        effectView.layer.cornerRadius = 8
        if #available(iOS 11.0, *) {
            effectView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        effectView.layer.masksToBounds = true
        return effectView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = UIFont.detailStrong.withSize(22)
        label.numberOfLines = 0
        label.textColor = .licorice
        return label
    }()

    private lazy var priceLabelShadow: UIVisualEffectView = {
        let effectView = UIVisualEffectView(withAutoLayout: true)
        effectView.effect = UIBlurEffect(style: .prominent)
        effectView.layer.cornerRadius = 6
        if #available(iOS 11.0, *) {
            effectView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        effectView.layer.masksToBounds = true
        return effectView
    }()

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

        contentView.backgroundColor = .red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        priceLabel.text = nil
        titleLabel.text = nil
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(priceLabelShadow)
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabelShadow)
        contentView.addSubview(titleLabel)

        imageView.fillInSuperview()

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -.largeSpacing),
            titleLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -.largeSpacing),

            titleLabelShadow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabelShadow.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -.smallSpacing),
            titleLabelShadow.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: .mediumLargeSpacing),
            titleLabelShadow.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .smallSpacing),

            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -.largeSpacing),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.veryLargeSpacing),

            priceLabelShadow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabelShadow.topAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -.smallSpacing),
            priceLabelShadow.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: .mediumLargeSpacing),
            priceLabelShadow.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: .smallSpacing),
        ])
    }

    // MARK: - Public methods

    public func configure(with viewModel: InstaObjectMainImageModel) {
        imageDownloader?.downloadImage(forUrl: viewModel.imageUrl, completion: { [weak self] image in
            guard let image = image else { return }
            self?.imageView.image = image
        })

        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.priceText
    }
}

extension InstaObjectMainImageCollectionViewCell: ScrollableCell {
    public func scrollViewDidScroll(contentOffset: CGFloat) {

        if contentOffset < 0 {
            imageView.transform = CGAffineTransform(translationX: 0, y: contentOffset)
        } else {
            imageView.transform = .identity
        }
        let offsetTransform = CGAffineTransform(translationX: 0, y: -contentOffset * 0.4)
        titleLabel.transform = offsetTransform
        titleLabelShadow.transform = offsetTransform
        priceLabel.transform = offsetTransform
        priceLabelShadow.transform = offsetTransform
    }
}
