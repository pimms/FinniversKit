//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

protocol InstaObjectViewModel { /* lol */ }

struct InstaObjectDescriptionModel: InstaObjectViewModel {
    let description: String
}

struct InstaObjectSingleImageModel: InstaObjectViewModel {
    let description: String
    let image: UIImage?
}

struct InstaObjectMainImageModel: InstaObjectViewModel {
    let title: String
    let priceText: String
    let image: UIImage?
}
