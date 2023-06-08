//
//  ViewController.swift
//  XKExtensions
//
//  Created by kenneth on 04/21/2022.
//  Copyright (c) 2022 kenneth. All rights reserved.
//

import UIKit
import XKExtensions
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = Self.xk_className
        
        let view1 = UIView()
        let view2 = UIView()
        
        print(view2.isHidden)
        view1.rx.hidden.bind(to: view2.rx.isHidden).disposed(by: disposeBag)
        view1.isHidden = true
        print(view2.isHidden)
        
        let y = XKConstants.navigationAndStatusBarHeight
        debugPrint(y)
        navigationController?.navigationBar.backgroundColor = .red
        let subView = UIView()
        subView.backgroundColor = .yellow
        subView.frame = CGRect(x: 0.0, y: y, width: XKConstants.screenWidth, height: 50.0)
        view.addSubview(subView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
}

