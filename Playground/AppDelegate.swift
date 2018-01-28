//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit
import Troika

extension NSNotification.Name {

    /// Notification used with http://johnholdsworth.com/injection.html
    /// 1.- Download the app http://johnholdsworth.com/Injection9.app.zip
    /// 2.- Open the app, enable File Watcher and press Inject Source
    /// 3.- After a change is done in a UIView or UIViewController instance this notification
    /// will be called and the UI will be reloaded live.
    static let InjectionNotification = Notification.Name(rawValue: "INJECTION_BUNDLE_NOTIFICATION")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, Viewable {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIFont.registerTroikaFonts()
        NotificationCenter.default.addObserver(self, selector: #selector(injected(notification:)), name: Notification.Name.InjectionNotification, object: nil)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = PlaygroundContainer()
        window?.makeKeyAndVisible()

        return true
    }

    @objc func injected(notification: NSNotification) {
        guard let subviews = window?.rootViewController?.view.subviews else {
            return
        }

        for subview in subviews {
            subview.removeFromSuperview()
        }

        window?.rootViewController?.viewDidLoad()
    }
}

public extension Bundle {

    static var playgroundBundle: Bundle {
        return Bundle(for: AppDelegate.self)
    }
}
