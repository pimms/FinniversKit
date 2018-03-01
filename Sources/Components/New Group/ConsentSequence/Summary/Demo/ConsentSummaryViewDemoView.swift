//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import FinniversKit

public class ConsentSummaryViewDemoView: UIView {
    private lazy var consentView: ConsentSummaryView = {
        let view = ConsentSummaryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder aDecoder: NSCoder) { fatalError() }

    private func setup() {
        consentView.model = ConsentSummaryViewDefaultData()

        addSubview(consentView)
        consentView.fillInSuperview()
    }
}
