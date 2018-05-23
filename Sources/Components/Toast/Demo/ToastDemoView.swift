//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import FinniversKit

class ToastClass: NSObject, ToastViewDelegate {
    func didTapActionButton(button: UIButton, in toastView: ToastView) {
        print("Button tapped \(toastView.style)")
    }

    func didTap(toastView: ToastView) {
        print("Toast view tapped \(toastView.style)")
    }
}

public class ToastDemoView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(tableView)
        tableView.fillInSuperview()
        tableView.dataSource = self

        tableView.register(UITableViewCell.self)

        let animatedToast = ToastView(style: .success)
        animatedToast.text = "Animated success"
        animatedToast.presentFromBottom(view: self, animateOffset: 0, timeOut: 5)
    }
}

extension ToastDemoView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = "Hi"
        return cell
    }
}
