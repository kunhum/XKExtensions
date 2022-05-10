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
        
        let view1 = UIView()
        let view2 = UIView()
        
        print(view2.isHidden)
        view1.rx.hidden.bind(to: view2.rx.isHidden).disposed(by: disposeBag)
        view1.isHidden = true
        print(view2.isHidden)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

