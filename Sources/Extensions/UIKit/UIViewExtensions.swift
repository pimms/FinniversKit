//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public extension UIView {
    convenience init(withAutoLayout autoLayout: Bool) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = !autoLayout
    }

    var compatibleTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }

    var compatibleBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }

    var safeLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        } else {
            return layoutMarginsGuide
        }
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offset: CGSize = CGSize.zero, radius: CGFloat = 10.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.rasterizationScale = UIScreen.main.scale
    }
}

// MARK: - Animate alongside keyboard

public extension UIView {
    class func animateAlongsideKeyboard(keyboardInfo: KeyboardNotificationInfo, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        let animationDuration = keyboardInfo.animationDuration
        let animationOptions = keyboardInfo.animationOptions

        animate(withDuration: animationDuration, delay: 0, options: animationOptions, animations: animations, completion: completion)
    }

    class func animateAlongsideKeyboard(keyboardInfo: KeyboardNotificationInfo, animations: @escaping () -> Void) {
        animateAlongsideKeyboard(keyboardInfo: keyboardInfo, animations: animations, completion: nil)
    }
}
