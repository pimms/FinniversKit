//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import FinniversKit

public struct ConsentSummaryViewDefaultData: ConsentSummaryViewModel {
    public var title = "Oppsummering"
    public var introDescription = "Dine valg"
    public var description = "Du kan alltid endre på dine samtykker senere under dine innstillinger."
    public var doneButtonTitle = "Ferdig"

    public var recommendationModel: ToggleSwitchViewModel {
        struct recommendationModel: ToggleSwitchViewModel {
            public let headerText = "Anbefalinger"
            public let onDescriptionText = "Vi gir deg relevante tips på forsiden"
            public let offDescriptionText = "Relevante tips er slått av"
            public init() {}
        }
        return recommendationModel.init()
    }

    public var commercialModel: ToggleSwitchViewModel {
        struct commercialModel: ToggleSwitchViewModel {
            public let headerText = "Smart reklame"
            public let onDescriptionText = "Vi leter for deg når du gjør andre ting"
            public let offDescriptionText = "Du får ikke relevant FINN-innhold når du ikke leter"
            public init() {}
        }
        return commercialModel.init()
    }

    public var improveModel: ToggleSwitchViewModel {
        struct improveModel: ToggleSwitchViewModel {
            public let headerText = "Forbedre FINN"
            public let onDescriptionText = "Dine data hjelper oss lage bedre tjenester"
            public let offDescriptionText = "Vi bruker ikke dine data til å lage bedre tjenester"
            public init() {}
        }
        return improveModel.init()
    }
    public init() {}
}
