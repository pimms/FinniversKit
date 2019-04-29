//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public protocol InstaObjectViewModel { /* lol */ }

public class InstaObjectDescriptionModel: InstaObjectViewModel {
    public let description: String

    public init(description: String) {
        self.description = description
    }
}

public class InstaObjectSingleImageModel: InstaObjectViewModel {
    public let description: String?
    public let imageUrl: URL

    public init(description: String?, imageUrl: URL) {
        self.description = description
        self.imageUrl = imageUrl
    }
}

public class InstaObjectMainImageModel: InstaObjectViewModel {
    public let title: String
    public let priceText: String
    public let imageUrl: URL

    public init(title: String, priceText: String, imageUrl: URL) {
        self.title = title
        self.priceText = priceText
        self.imageUrl = imageUrl
    }
}
