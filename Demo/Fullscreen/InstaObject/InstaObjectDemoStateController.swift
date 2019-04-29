//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import FinniversKit

class InstaObjectDemoStateController: UIViewController {
    private let model = InstaObjectDummyBaseModel(
                                  imageURLs: [
                                      URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/24/4/145/775/794_1562625557.jpg")!,
                                      URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/28/3/146/090/653_542084614.jpg")!,
                                      URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/28/3/146/090/653_1705328036.jpg")!
                                  ],
                                  imageDescriptions: [ "Fin sykkel", nil, "Rosa og fin, denne kan bli din!" ],
                                  title: "Flott sykkel",
                                  priceText: "Gis bort",
                                  description: "Fin sykkel gis bort mot henting.\nDen er ganske fin.\n\nSykkelen kan ikke trilles, den må dyttes.\n\nGrønt hus.\n\nFlink bisk.")

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        let splitter = InstaObjectDemoSplitter()
        let viewModel = splitter.splitDummyModel(model)

        let viewController = InstaObjectViewController()
        viewController.delegate = self
        viewController.viewModels = viewModel

        addChild(viewController)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}

extension InstaObjectDemoStateController: InstaObjectViewControllerDelegate {
    func downloadThatImageBoy(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }

        task.resume()
    }
}
