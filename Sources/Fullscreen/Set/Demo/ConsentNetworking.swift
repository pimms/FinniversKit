//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import Foundation

class ConsentNetworking {

    let url = URL(string: "https://appsgw.finn.no/external/consents/test/last")

    func givenConsents(forUser userID: String) {
        guard let url = url else { return }

        var request = URLRequest(url: url)
        request.addValue("Consent-sink", forHTTPHeaderField: "FINN-GW-Service")

        let datatask = URLSession.shared.dataTask(with: request) { (data, respons, error) in
            guard error == nil else {
                print("Network error:", error)
                return
            }

            guard let data = data else { return }
            print("Data count:", data.count)
            let text = String(data: data, encoding: .utf8)
            print("Data string:", text)

            let decoder = JSONDecoder()
            guard let content = try? decoder.decode(Definition.self, from: data) else {
                print("Error decoding JSON")
                return
            }

            print("JSON content:", content)
        }
        datatask.resume()
    }

}
