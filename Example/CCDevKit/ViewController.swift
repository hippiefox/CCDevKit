//
//  ViewController.swift
//  CCDevKit
//
//  Created by ccczuo on 08/05/2021.
//  Copyright (c) 2021 ccczuo. All rights reserved.
//

import UIKit
import CCDevKit
class ViewController: UIViewController {
    
    lazy private var button :UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(actionClick), for: .touchUpInside)
        view.setTitle("click", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.center = view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func actionClick(){
        let vc = CCWebViewController.init(.init(string: "https://www.baidu.com")!)
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

}

