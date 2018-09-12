//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import UIKit

class SettingsHeader: UIView {

    let titleLabel = Label(style: .title3)

    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
