import Foundation

public class InstaObjectDescriptionCollectionViewCell: UICollectionViewCell {

    // MARK: - Private properties

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = .title3
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.backgroundColor = .blue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    public override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(descriptionLabel)

        descriptionLabel.fillInSuperview(insets: UIEdgeInsets(top: .veryLargeSpacing, leading: .largeSpacing, bottom: -.veryLargeSpacing, trailing: -.largeSpacing))
    }

    // MARK: - Public methods

    public func configure(with viewModel: InstaObjectDescriptionModel) {
        descriptionLabel.text = viewModel.description
    }
}

// MARK: - ScrollableCell

extension InstaObjectDescriptionCollectionViewCell: ScrollableCell {
    public func scrollViewDidScroll(contentOffset: CGFloat) {
        let adjustedOffset = (frame.midY - contentOffset) - UIScreen.main.bounds.midY
        // 👆 Difference between cell center and screen center. Maybe useful for something..?
    }
}
