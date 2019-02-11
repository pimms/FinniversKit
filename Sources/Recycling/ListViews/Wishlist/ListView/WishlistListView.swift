//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public protocol WishlistListViewDataSource: class {
    func numberOfItemsInWishlistListView(_ wishlistListView: WishlistListView) -> Int
    func wishlistListView(_ wishlistListView: WishlistListView, modelAtIndex index: Int) -> WishlistListViewModel
    func wishlistListView(_ wishlistListView: WishlistListView,
                          loadImageForModel model: WishlistListViewModel,
                          completion: @escaping (WishlistListViewModel, UIImage?) -> Void)
}

public protocol WishlistListViewDelegate: class {
    func wishlistListView(_ wishlistListView: WishlistListView, didSelectRowAt indexPath: IndexPath)
}

public class WishlistListView: UIView {

    // MARK: - Private properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 362
        return tableView
    }()

    // MARK: - Public properties

    public weak var dataSource: WishlistListViewDataSource?
    public weak var delegate: WishlistListViewDelegate?

    // MARK: - Init

    public init(dataSource: WishlistListViewDataSource, delegate: WishlistListViewDelegate) {
        super.init(frame: .zero)
        self.dataSource = dataSource
        self.delegate = delegate
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        tableView.register(WishlistListViewCell.self)

        addSubview(tableView)
        tableView.fillInSuperview()
    }
}

extension WishlistListView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.wishlistListView(self, didSelectRowAt: indexPath)
    }
}

extension WishlistListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfItemsInWishlistListView(self) ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(WishlistListViewCell.self, for: indexPath)
        cell.delegate = self

        if let model = dataSource?.wishlistListView(self, modelAtIndex: indexPath.row) {
            cell.model = model
        }

        let loadingColors: [UIColor] = [ .toothPaste, .salmon, .mint, .banana, .sardine ]
        cell.loadingColor = loadingColors[indexPath.row % loadingColors.count]

        return cell
    }
}

extension WishlistListView: WishlistListViewCellDelegate {
    func wishlistCell(_ cell: WishlistListViewCell,
                      imageForModel model: WishlistListViewModel,
                      completion: @escaping (WishlistListViewModel, UIImage?) -> Void) {
        guard let dataSource = dataSource else {
            completion(model, nil)
            return
        }

        dataSource.wishlistListView(self, loadImageForModel: model, completion: completion)
    }
}
