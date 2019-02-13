//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import FinniversKit

struct WishlistAdItem: WishlistListViewModel {
    var adId: Int64
    var publishedDate: Date
    var isActive: Bool
    var title: String
    var imageUrl: String?
    var price: Int?
    var location: String
}

class WishlistAdFactory {

    static func create() -> [WishlistAdItem] {
        var uniqueAds = [WishlistAdItem]()

        for index in 0 ..< 4 {
            let ad = WishlistAdItem(adId: adIds[index],
                                    publishedDate: publishedDates[index],
                                    isActive: active[index],
                                    title: titles[index],
                                    imageUrl: imageUrls[index],
                                    price: prices[index],
                                    location: locations[index])
            uniqueAds.append(ad)
        }

        var wishlist = [WishlistAdItem]()
        for _ in 0 ..< 20 {
            let ad = uniqueAds[Int(arc4random()) % uniqueAds.count]
            wishlist.append(ad)
        }

        return wishlist
    }

    private static let adIds: [Int64] = [
        123,
        234,
        345,
        456,
    ]

    private static let publishedDates: [Date] = [
        Date.init(timeIntervalSinceNow: -300),
        Date.init(timeIntervalSinceNow: -3600),
        Date.init(timeIntervalSinceNow: -86400 * 5),
        Date.init(timeIntervalSinceNow: -86400 * 16),
    ]

    private static let active: [Bool] = [
        true,
        false,
        true,
        true,
    ]

    private static let titles: [String] = [
        "Oboy (brukerdose)",
        "Ski",
        "Vestvendt villa med kort vei til marka, T-bane, trikk og nærbutikk. Kan ikke beskrives, må oppleves!",
        "10 x 1.5L melk",
    ]

    private static let imageUrls: [String?] = [
        "https://images.finncdn.no/dynamic/1280w/2018/9/vertical-5/11/8/129/024/868_255688828.jpg",
        nil,
        "http://jonvilma.com/images/house-6.jpg",
        "https://www.tine.no/presserom/nyhetsarkiv/kjente-gardsysterier-pa-tines-melkekartonger-over-hele-landet/_/image/2ac51ef1-d0e3-4777-94e0-093e9ed598b9:26fbaf5af4b5b67cb1878808c4a68242da1ef590/block-1200-630/6e2e060f-e332-4968-812d-c4ca30e5b719.jpg?quality=85",
    ]

    private static let prices: [Int?] = [
        350,
        nil,
        10000000,
        0,
    ]

    private static let locations: [String] = [
        "Skøyen",
        "Ski",
        "Oslo",
        "Skagerak",
    ]
}
