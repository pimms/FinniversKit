//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public protocol InstaObjectViewControllerDelegate: AnyObject {
    func instaObjectViewController(_ vc: InstaObjectViewController, fetchImageWithUrl url: URL, completion: @escaping (UIImage?) -> Void)
}

public class InstaObjectViewController: UIViewController {

    // MARK: - Public properties

    public weak var delegate: InstaObjectViewControllerDelegate?

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(delegate: InstaObjectViewControllerDelegate, model: InstaObjectViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate


    }
}
