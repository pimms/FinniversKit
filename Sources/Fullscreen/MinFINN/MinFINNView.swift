//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public protocol ReviewViewDelegate: NSObjectProtocol {
    func reviewView(_ reviewView: ReviewView, loadImageForModel model: ReviewViewProfileModel, imageWidth: CGFloat, completion: @escaping ((UIImage?) -> Void)) -> UIImage?
    func reviewView(_ reviewView: ReviewView, cancelLoadingImageForModel model: ReviewViewProfileModel)
    func reviewView(_ reviewView: ReviewView, didSelect user: ReviewViewProfileModel)
}

public class ReviewView: UIView {
    static let defaultRowHeight: CGFloat = 40

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(ReviewTextHeader.self)
        tableView.register(ReviewProfileCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = ReviewView.defaultRowHeight
        tableView.estimatedSectionHeaderHeight = ReviewView.defaultRowHeight
        return tableView
    }()

    public weak var delegate: ReviewViewDelegate?

    public var model: ReviewViewModel? {
        didSet {
            tableView.reloadData()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(tableView)
        tableView.fillInSuperview()
    }
}

extension ReviewView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.profiles.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model?.profiles[indexPath.row] else {
            return UITableViewCell()
        }

        return reviewProfileCell(tableView: tableView, for: indexPath, model: model)
    }

    private func reviewProfileCell(tableView: UITableView, for indexPath: IndexPath, model: ReviewViewProfileModel) -> UITableViewCell {
        let cell = tableView.dequeue(ReviewProfileCell.self, for: indexPath)
        cell.model = model
        cell.delegate = self
        cell.loadImage()

        return cell
    }
}

extension ReviewView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeue(ReviewTextHeader.self)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.title.text = model?.title
        header.subtitle.text = model?.subtitle

        return header
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let user = model?.profiles[indexPath.row] else {
            return
        }

        delegate?.reviewView(self, didSelect: user)
    }
}

extension ReviewView: ReviewProfileCellDelegate {
    func reviewProfileCell(_ reviewProfileCell: ReviewProfileCell, loadImageForModel model: ReviewViewProfileModel, imageWidth: CGFloat, completion: @escaping ((UIImage?) -> Void)) -> UIImage? {
        return delegate?.reviewView(self, loadImageForModel: model, imageWidth: imageWidth, completion: completion)
    }

    func reviewProfileCell(_ reviewProfileCell: ReviewProfileCell, cancelLoadingImageForModel model: ReviewViewProfileModel) {
        delegate?.reviewView(self, cancelLoadingImageForModel: model)
    }
}
