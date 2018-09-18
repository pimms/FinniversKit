//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import FinniversKit

class ConsentDemoView: UIView {

    let sections = [
        Section(title: "Varslinger", items: [ConsentViewCellModel(title: "Meldinger", state: nil),
                                             ConsentViewCellModel(title: "Lagrede Søk", state: nil),
                                             ConsentViewCellModel(title: "Prisnedgang på Torget", state: nil)]),
        Section(title: "Personvern", items: [ConsentViewCellModel(title: "Få nyhetsbrev fra FINN", state: .off),
                                             ConsentViewCellModel(title: "Personlig tilpasset FINN", state: .on),
                                             ConsentViewCellModel(title: "Motta viktig informasjon fra FINN", state: .on),
                                             ConsentViewCellModel(title: "Smart reklame", state: nil),
                                             ConsentViewCellModel(title: "Last ned dine data", state: nil),
                                             ConsentViewCellModel(title: "Slett meg som bruker", state: nil)])
    ]

    var dataSource: ConsentDataSource?

    lazy var consentView: ConsentView = {
        let view = ConsentView(frame: .zero, style: .grouped)
        view.dataSource = self
        view.delegate = self
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ConsentDemoView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConsentViewCell.identifier, for: indexPath) as? ConsentViewCell else { return UITableViewCell() }
        cell.set(model: sections[indexPath.section].items[indexPath.row])
        return cell
    }
}

extension ConsentDemoView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return consentView.headerView(for: section, with: sections[section].title)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
    }
}

private extension ConsentDemoView {

    func setupSubviews() {
        addSubview(consentView)
        let constraints = [
            consentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            consentView.topAnchor.constraint(equalTo: topAnchor),
            consentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            consentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
