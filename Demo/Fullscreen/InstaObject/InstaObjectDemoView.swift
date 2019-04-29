//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import FinniversKit

private struct DemoModel: InstaObjectViewModel {
    let imageURLs: [URL]?
    let title: String
    let priceText: String
    let description: String?
}

class InstaObjectDemoView: UIView {
    private let model = DemoModel(imageURLs: [
                                    URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/24/4/145/775/794_1562625557.jpg")!,
                                    URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/28/3/146/090/653_542084614.jpg")!,
                                    URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/28/3/146/090/653_1705328036.jpg")!
                                    ],
                                  title: "Flott sykkel",
                                  priceText: "Gis bort",
                                  description: "Fin sykkel gis bort mot henting.")

    private lazy var instaView: InstaObjectView = {
        let view = InstaObjectView(withAutoLayout: true)
        return view
    }()

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        instaView.fillInSuperview()
    }
}
