//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import Foundation

struct UserConsent: Codable {
    let userID: String
    let userType: String
    let name: String
    let version: Int
    let action: String
    let actionText: String
    let actionPerformer: String
}

struct Definition: Codable {
    let name: String?
    let version: Int?
    let text: String?
    let message: String?
}

struct Purpose: Codable {
    let name: String
    let heading: String
    let description: String
}

struct Consent: Codable {
    let userConsent: UserConsent
    let definition: Definition
    let purpose: Purpose
}

struct LegitimateInterest: Codable {
    let purpose: Purpose
}

struct GivenConsents: Codable {
    let consents: [Consent]
    let legitimateInterests: [LegitimateInterest]
}
