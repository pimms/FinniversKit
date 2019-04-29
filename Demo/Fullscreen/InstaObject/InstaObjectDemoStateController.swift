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

    let viewModel: [InstaObjectViewModel] = [
        InstaObjectMainImageModel(title: "Flott sykkel", priceText: "Gis bort", imageUrl: URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/24/4/145/775/794_1562625557.jpg")!),
        InstaObjectDescriptionModel(description: "Dette er en fin sykkel du kan sykle masse på. 10/10, du burde hente den."),
        InstaObjectSingleImageModel(description: "Pen sykkel – har vært brukt av kongen", imageUrl: URL(string: "https://images.finncdn.no/dynamic/1600w/2019/4/vertical-5/28/3/146/090/653_542084614.jpg")!)
    ]

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)

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
