//
//  ViewController.swift
//  XKExtensions
//
//  Created by kenneth on 04/21/2022.
//  Copyright (c) 2022 kenneth. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import XKExtensions

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = Self.xk_className
        
        let panView = UIView()
        panView.backgroundColor = .yellow
        panView.frame = CGRectMake(100.0, 100.0, 80.0, 80.0)
        panView.panEdges = UIEdgeInsets(top: XKConstants.navigationAndStatusBarHeight,
                                        left: 10.0,
                                        bottom: XKConstants.safeAreaInsets.bottom,
                                        right: 10.0)
        view.addSubview(panView)
        
        let pan = UIPanGestureRecognizer(target: panView, action: #selector(panView.xk_panGestureMethod(pan:)))
        panView.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

