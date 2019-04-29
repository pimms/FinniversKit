//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public protocol InstaObjectViewControllerDelegate: AnyObject {
    func downloadThatImageBoy(url: URL, completion: @escaping (UIImage?) -> Void)
}

public class InstaObjectViewController: UIViewController {

    public weak var delegate: InstaObjectViewControllerDelegate?
    public var viewModels: [InstaObjectViewModel] = []

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .milk
    }
}
