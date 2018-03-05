//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

public protocol ConsentSummaryViewModel {
    var title: String { get }
    var introDescription: String { get }
    var description: String { get }
    var doneButtonTitle: String { get }
    var recommendationModel: ToggleSwitchViewModel { get }
    var commercialModel: ToggleSwitchViewModel { get }
    var improveModel: ToggleSwitchViewModel { get }
}
