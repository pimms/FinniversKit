//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import FinniversKit

class SettingsDemoView: UIView {

    lazy var settingsView: SettingsView = {
        let view = SettingsView(frame: .zero, style: .plain)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
