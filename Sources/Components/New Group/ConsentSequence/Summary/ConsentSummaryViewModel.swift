//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

public protocol ConsentSummaryViewModel {
    var title: String { get }
    var introDescription: String { get }
    var description: String { get }
    var recommendationTitle: String { get }
    var commercialTitle: String { get }
    var improveTitle: String { get }
    var doneButtonTitle: String { get }
}
