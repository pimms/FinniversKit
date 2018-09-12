//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import FinniversKit

class SettingsDemoView: UIView {

    let sections = [
        Section(title: "Varslinger", rows: 3, items: ["Meldinger", "Lagrede Søk", "Prisnedgang på Torget"]),
        Section(title: "Personvern", rows: 3, items: ["Få nyhetsbrev fra FINN", "Personlig tilpasset FINN", "Motta viktig informasjon fra FINN"])
    ]

    lazy var settingsView: SettingsView = {
        let view = SettingsView(frame: .zero, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
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

extension SettingsDemoView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = .body
        cell.textLabel?.text = sections[indexPath.section].item(for: indexPath)
        return cell
    }
}

extension SettingsDemoView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)

        let label = Label(style: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = sections[section].title

        view.addSubview(label)

        let constraints = [
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .mediumLargeSpacing),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: .mediumSpacing),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.mediumLargeSpacing),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.mediumSpacing),
        ]

        NSLayoutConstraint.activate(constraints)

        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
    }
}

private extension SettingsDemoView {

    func setupSubviews() {
        addSubview(settingsView)
        let constraints = [
            settingsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            settingsView.topAnchor.constraint(equalTo: topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            settingsView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
