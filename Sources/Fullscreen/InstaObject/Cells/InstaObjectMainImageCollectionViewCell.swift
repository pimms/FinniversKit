import Foundation

public class InstaObjectMainImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Public properties

    weak var imageDownloader: ImageDownloader?

    // MARK: - Private properties

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = .title1
        label.numberOfLines = 0
        label.textColor = .milk
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = .title3
        label.numberOfLines = 0
        label.textColor = .milk
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

        let attrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.milk, .strokeColor: UIColor.stone, .strokeWidth: -3.0]
        titleLabel.attributedText = NSAttributedString(string: viewModel.title, attributes: attrs)
        priceLabel.attributedText = NSAttributedString(string: viewModel.priceText, attributes: attrs)
    }
}
