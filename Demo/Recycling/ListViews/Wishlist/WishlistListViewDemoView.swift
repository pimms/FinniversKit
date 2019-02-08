//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import FinniversKit

class WishlistListViewDemoView: UIView {
    lazy private var wishlist = WishlistAdFactory.create()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let wishlistView = WishlistListView()
        wishlistView.translatesAutoresizingMaskIntoConstraints = false
        wishlistView.dataSource = self
        wishlistView.delegate = self
        addSubview(wishlistView)
        wishlistView.fillInSuperview()
    }
}

extension WishlistListViewDemoView: WishlistListViewDataSource {
    func wishlistListView(_ wishlistListView: WishlistListView,
                          loadImageForModel model: WishlistListViewModel,
                          completion: @escaping (WishlistListViewModel, UIImage?) -> Void) {
        guard let urlString = model.imageUrl, let url = URL(string: urlString) else {
            completion(model, nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            DispatchQueue.main.sync {
                if let data = data, let image = UIImage(data: data) {
                    completion(model, image)
                } else {
                    completion(model, nil)
                }
            }
        })

        task.resume()
    }

    func numberOfItemsInWishlistListView(_ wishlistListView: WishlistListView) -> Int {
        return wishlist.count
    }

    func wishlistListView(_ wishlistListView: WishlistListView, modelAtIndex index: Int) -> WishlistListViewModel {
        return wishlist[index]
    }
}

extension WishlistListViewDemoView: WishlistListViewDelegate {

}
