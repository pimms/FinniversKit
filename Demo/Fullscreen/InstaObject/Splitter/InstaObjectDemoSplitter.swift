//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import FinniversKit

class InstaObjectDemoSplitter {
    func splitDummyModel(_ dummyModel: InstaObjectDummyBaseModel) -> [InstaObjectViewModel] {
        var sections: [InstaObjectViewModel] = []

        sections.append(InstaObjectMainImageModel(title: dummyModel.title, priceText: dummyModel.priceText, imageUrl: dummyModel.imageURLs![0]))

        let descriptions = splitDescription(dummyModel.description, maxSplits: (dummyModel.imageURLs?.count ?? 2) - 1)

        if let urls = dummyModel.imageURLs {
            for i in 0..<urls.count {
                if (descriptions?.count ?? 0) > i {
                    sections.append(InstaObjectDescriptionModel(description: descriptions![i]))
                }

                sections.append(InstaObjectSingleImageModel(description: dummyModel.imageDescriptions?[safe: i] ?? nil, imageUrl: urls[i]))
            }
        } else if let descriptions = descriptions, descriptions.count > 0 {
            sections.append(InstaObjectDescriptionModel(description: descriptions[0]))
        }

        return sections
    }

    private func splitDescription(_ desc: String?, maxSplits: Int) -> [String]? {
        guard let desc = desc?.replacingOccurrences(of: "\r", with: "") else { return nil }

        var buffer = ""
        var lines: [String] = []

        desc.enumerateLines { (str, _) in
            if lines.count + 1 >= maxSplits {
                if buffer != "" {
                    buffer += "\n"
                }
                buffer += "\(str)"
            } else if str == "" {
                if buffer != "" {
                    lines.append(buffer)
                    buffer = ""
                }
            } else {
                if buffer != "" {
                    buffer += "\n"
                }
                buffer += "\(str)"
            }
        }

        lines.append(buffer)
        return lines
    }
}
