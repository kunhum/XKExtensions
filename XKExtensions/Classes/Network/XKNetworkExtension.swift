//
//  XKNetworkExtension.swift
//  XKExtensions
//
//  Created by Kenneth Tse on 2025/10/1.
//

import Foundation
import RxSwift
import MJRefresh
import XKNetwork

public extension XKRxModelProtocol {
    
    func autoRefresh(view: UIView? = nil, header: MJRefreshHeader? = nil, footer: MJRefreshFooter? = nil) -> Disposable {
        
        weak var weakHeader = header
        weak var weakFooter = footer
        
        var endRefresh: (MJRefreshHeader?, MJRefreshFooter?) -> Void = {
            (header, footer) in
            if header?.isRefreshing == true {
                header?.endRefreshing()
            }
            if footer?.isRefreshing == true {
                footer?.endRefreshing()
            }
        }
        
        func handle(state: XKRefreshState) {
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .fetchData:
                break
            case .headerRefresh:
                weakFooter?.resetNoMoreData()
            case .footerRefresh:
                break
            case .footerNoMoreData:
                endRefresh(weakHeader, nil)
                weakFooter?.endRefreshingWithNoMoreData()
                weakFooter?.isHidden = false
            case .completed:
                endRefresh(weakHeader, weakFooter)
                weakFooter?.isHidden = false
            case .noData:
                endRefresh(weakHeader, weakFooter)
                weakFooter?.isHidden = true
            case .error(let moyaError):
                break
            }
        }
        
        return refreshSubject
            .subscribe { state in
                handle(state: state)
            }

    }
    
}
