//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public protocol InstaObjectViewDataSource: AnyObject {
    func instaObjectView(_ view: InstaObjectView)
}

public class InstaObjectView: UIView {

    // MARK: - Public properties

    public weak var dataSource: InstaObjectViewDataSource?

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
