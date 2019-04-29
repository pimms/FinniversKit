//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

protocol InstaObjectSectionViewModel { /* lol */ }

struct InstaObjectDescriptionModel: InstaObjectSectionViewModel {
    let description: String
}

struct InstaObjectSingleImageModel: InstaObjectSectionViewModel {
    let description: String
    let image: UIImage?
}

struct InstaObjectMainImageModel: InstaObjectSectionViewModel {
    let title: String
    let priceText: String
    let image: UIImage?
}
