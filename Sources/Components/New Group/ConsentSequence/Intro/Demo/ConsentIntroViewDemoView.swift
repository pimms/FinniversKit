//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import FinniversKit

public class ConsentIntroViewDemoView: UIView {
    private lazy var consentView: ConsentIntroView = {
        let view = ConsentIntroView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder aDecoder: NSCoder) { fatalError() }

    private func setup() {
        consentView.model = ConsentIntroViewDefaultData()

        addSubview(consentView)
        consentView.fillInSuperview()
    }
}
