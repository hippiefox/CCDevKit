//
//  CCNavigationController.swift
//  CCDevKit
//
//  Created by cc on 2021/8/5.
//

import Foundation
import UIKit

open class CCNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    public static var naviBackImage: UIImage? = {
        let bundle = Bundle.init(for: CCNavigationController.self)
        guard let path = bundle.path(forResource: "nav_back@2x.png", ofType: nil) else{
            return nil
        }
        return UIImage.init(contentsOfFile: path)
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }

        if viewControllers.count >= 1 {
            if let image = CCNavigationController.naviBackImage {
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(popViewController(animated:)))
            } else {
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(popViewController(animated:)))
            }
            interactivePopGestureRecognizer?.delegate = self
        }

        super.pushViewController(viewController, animated: animated)
    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count != 1
    }
}

extension UINavigationController {
    public func cc_pushViewController(_ controller: UIViewController, animated: Bool, completion: () -> Void) {
        pushViewController(controller, animated: animated)
        completion()
    }

    public func cc_removeViewController(_ controller: UIViewController) {
        guard viewControllers.count > 1,
              let index = viewControllers.firstIndex(of: controller)
        else { return }

        var newControllers = viewControllers
        controller.removeFromParent()
        newControllers.remove(at: index)
        setViewControllers(newControllers, animated: true)
    }
}
