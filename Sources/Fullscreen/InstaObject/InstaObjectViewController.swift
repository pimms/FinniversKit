//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public protocol InstaObjectViewControllerDelegate: AnyObject {
    func downloadThatImageBoy(url: URL, completion: @escaping (UIImage?) -> Void)
}

public class InstaObjectViewController: UIViewController {

    // MARK: - Public properties

    public weak var delegate: InstaObjectViewControllerDelegate?
    public var viewModels: [InstaObjectViewModel] = []

    // MARK: - UI properties

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.delegate = self
        view.dataSource = self

        view.register(InstaObjectMainImageCollectionViewCell.self)
        view.register(InstaObjectImageCollectionViewCell.self)
        view.register(InstaObjectDescriptionCollectionViewCell.self)

        return view
    }()

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .milk
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private methods

    private func setup() {
        view.addSubview(collectionView)
        collectionView.fillInSuperview()

        // Fuck the police 🚫👮‍♀️
        if #available(iOS 11.0, *) {
            let top = max(20, UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0)
            collectionView.contentInset = UIEdgeInsets(top: -top, left: 0, bottom: 0, right: 0)
        } else {
            collectionView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        }
    }
}

// MARK: UICollectionView Delegate & Data Source

extension InstaObjectViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModels[indexPath.row]

        switch model {
        case let mainImageModel as InstaObjectMainImageModel:
            let cell = collectionView.dequeue(InstaObjectMainImageCollectionViewCell.self, for: indexPath)
            cell.configure(with: mainImageModel)
            return cell

        case let singleImageModel as InstaObjectSingleImageModel:
            let cell = collectionView.dequeue(InstaObjectImageCollectionViewCell.self, for: indexPath)
            cell.configure(with: singleImageModel)
            return cell

        case let descriptionModel as InstaObjectDescriptionModel:
            let cell = collectionView.dequeue(InstaObjectDescriptionCollectionViewCell.self, for: indexPath)
            cell.configure(with: descriptionModel)
            return cell

        default:
            fatalError("Unhandled model-type: \(model) (\(model.self))")
        }
    }
}

extension InstaObjectViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = viewModels[indexPath.row]

        switch model {
        case is InstaObjectMainImageModel, is InstaObjectSingleImageModel:
            return collectionView.bounds.size

        case let descriptionModel as InstaObjectDescriptionModel:
            let screenWidth = collectionView.bounds.size.width
            let labelWidth = screenWidth - CGFloat.largeSpacing * 2
            let labelHeight = descriptionModel.description.height(withConstrainedWidth: labelWidth, font: .title3)
            let height = labelHeight + CGFloat.veryLargeSpacing * 2
            return CGSize(width: screenWidth, height: height)

        default:
            fatalError("Unhandled model-type: \(model) (\(model.self))")
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
