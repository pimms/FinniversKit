//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import FinniversKit

// MARK: - DemoViewsTableViewController

class DemoViewsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self)
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = "Hi"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animatedToast = ToastView(style: .success)
        animatedToast.text = "Animated success"
        animatedToast.presentFromBottom(view: tableView, animateOffset: 0, timeOut: 5)
    }
}
