//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import FinniversKit

private struct DemoModel: InstaObjectViewModel {
    let imageURLs: [URL]?
    let imageDescriptions: [String?]?
    let title: String
    let priceText: String
    let description: String?
}

class InstaObjectDemoStateController: UIViewController {
    private let model = DemoModel(imageURLs: [
                                    URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/24/4/145/775/794_1562625557.jpg")!,
                                    URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/28/3/146/090/653_542084614.jpg")!,
                                    URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/28/3/146/090/653_1705328036.jpg")!
                                    ],
                                  imageDescriptions: [ "Fin sykkel", nil, "Rosa og fin, denne kan bli din!" ],
                                  title: "Flott sykkel",
                                  priceText: "Gis bort",
                                  description: "Fin sykkel gis bort mot henting.")

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
}
