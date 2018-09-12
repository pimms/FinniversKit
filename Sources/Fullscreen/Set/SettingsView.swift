//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import UIKit

public struct Section {
    public let title: String
    public let rows: Int
    public let items: [String]

    public init(title: String, rows: Int, items: [String]) {
        self.title = title
        self.rows = rows
        self.items = items
    }

    public func item(for indexPath: IndexPath) -> String {
        return items[indexPath.row]
    }
}

public class SettingsView: UITableView {
    
}
