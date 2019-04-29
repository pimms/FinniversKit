//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public class InstaObjectViewController: UIViewController {

    var viewModels: [InstaObjectSectionViewModel] = []

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
}
