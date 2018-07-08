//
// CIHamburgerMenuViewController.swift
// CIUIFramework
//
// Copyright © 2018 Code Infiniti (www.codeinfiniti.com).
// Created by Syed Arsalan Pervez on 24/06/2018.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

public protocol CIHamburgerMenuViewControllerDelegate {
    func toggleHamburgerMenu()
}

open class CIHamburgerMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CIHamburgerMenuViewControllerDelegate {
    public var defaultViewControllerKey: String?
    public var viewControllers = [AnyHashable: UIViewController]()
    
    lazy var hamburgerManuTableView = CIHamburgerMenuTableView()
    lazy var container = UIView()
    var menuIsVisible = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hamburgerManuTableView.delegate = self
        hamburgerManuTableView.dataSource = self
        hamburgerManuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        hamburgerManuTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height)
        view.addSubview(hamburgerManuTableView)
        
        container.frame = UIScreen.main.bounds
        view.addSubview(container)
        
        if let defaultViewControllerKey = defaultViewControllerKey, viewControllers.count > 0 {
            displayController(withKey: defaultViewControllerKey)
        }
    }
    
    public func displayController(withKey key: String) {
        if viewControllers.keys.contains(key) {
            if let controller = viewControllers[key] {
                for subview in container.subviews {
                    subview.removeFromSuperview()
                }
                controller.view.frame = container.frame
                container.addSubview(controller.view)
            }
        }
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
    }
    
    open func toggleHamburgerMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            [weak self] in
            if let strongSelf = self {
                if strongSelf.menuIsVisible {
                    strongSelf.menuIsVisible = false
                    strongSelf.container.transform = CGAffineTransform.identity
                } else {
                    strongSelf.menuIsVisible = true
                    strongSelf.container.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2, y: 0)
                }
            }
        }, completion: nil)
    }
}
