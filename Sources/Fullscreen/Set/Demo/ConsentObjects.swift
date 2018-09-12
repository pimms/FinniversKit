//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import Foundation

struct UserConsent {
    let userID: String
    let userType: String
    let name: String
    let version: Int
    let action: String
    let actionText: String
    let actionPerformer: String
}

struct Definition {
    let name: String
    let version: Int
    let text: String
}

struct Purpose {
    let name: String
    let heading: String
    let description: String
}

struct Consent {
    let userConsent: UserConsent
    let definition: Definition
    let purpose: Purpose
}

struct LegitimateInterest {
    let purpose: Purpose
}

struct GivenConsents {
    let consents: [Consent]
    let legitimateInterests: [LegitimateInterest]
}
