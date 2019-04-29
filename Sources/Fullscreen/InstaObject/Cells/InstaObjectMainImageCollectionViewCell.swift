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
        label.textColor = .milk

        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.6
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false

        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = UIFont.detailStrong.withSize(22)
        label.numberOfLines = 0
        label.textColor = .milk

        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.6
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false

        return label
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
        priceLabel.attributedText = nil
        titleLabel.attributedText = nil
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)

        imageView.fillInSuperview()

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),
            titleLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -.largeSpacing),

            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.veryLargeSpacing)
        ])
    }

    // MARK: - Public methods

    public func configure(with viewModel: InstaObjectMainImageModel) {
        imageDownloader?.downloadImage(forUrl: viewModel.imageUrl, completion: { [weak self] image in
            guard let image = image else { return }
            self?.imageView.image = image
        })

        titleLabel.attributedText = NSAttributedString(string: viewModel.title, attributes: [.foregroundColor: UIColor.milk, .strokeColor: UIColor.black.withAlphaComponent(0.6), .strokeWidth: -2.0])
        priceLabel.attributedText = NSAttributedString(string: viewModel.priceText, attributes: [.foregroundColor: UIColor.milk, .strokeColor: UIColor.black.withAlphaComponent(0.6), .strokeWidth: -2.0])
    }
}