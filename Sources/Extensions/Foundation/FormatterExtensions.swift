//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: Formatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

public extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
