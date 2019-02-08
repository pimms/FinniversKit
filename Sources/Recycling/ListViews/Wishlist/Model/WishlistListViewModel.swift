//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import Foundation

public protocol WishlistListViewModel {
    var adId: Int64 { get }
    var publishedDate: Date { get }
    var isActive: Bool { get }
    var title: String { get }
    var imageUrl: String? { get }
    var price: Int? { get }
    var location: String { get }
}

public extension WishlistListViewModel {
    var accessibilityLabel: String {
        var message = title
        message += ". " + location
        return message
    }
}
