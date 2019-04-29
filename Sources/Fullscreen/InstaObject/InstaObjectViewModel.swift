//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import Foundation

public protocol InstaObjectViewModel {
    var imageURLs: [URL]? { get }
    var title: String { get }
    var priceText: String { get }
    var description: String? { get }
}
