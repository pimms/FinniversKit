import Foundation
import UIKit

public protocol ImageDownloader: AnyObject {
    func downloadImage(forUrl url: URL, completion: @escaping (UIImage?) -> Void)
}

public class InstaObjectImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Public properties

    public weak var imageDownloader: ImageDownloader?

    // MARK: - Private properties

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = .bodyStrong
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

        contentView.backgroundColor = .yellow
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        descriptionLabel.text = nil
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)

        imageView.fillInSuperview()
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .largeSpacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.largeSpacing),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumLargeSpacing)
        ])
    }

    // MARK: - Public methods

    public func configure(with viewModel: InstaObjectSingleImageModel) {
        imageDownloader?.downloadImage(forUrl: viewModel.imageUrl, completion: { [weak self] image in
            guard let image = image else { return }
            self?.imageView.image = image
        })
    }
}
