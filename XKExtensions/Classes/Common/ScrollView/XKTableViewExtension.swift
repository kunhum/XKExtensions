//
//  XKTableViewExtension.swift
//  XKExtensions
//
//  Created by kenneth on 2022/4/21.
//

import Foundation

public extension UITableView {
    
    class func setupCommonConfigration() {
        let appearance = UITableView.appearance()
        appearance.separatorStyle = .none
        appearance.backgroundColor = .clear
        appearance.separatorColor = .xkSeparator
        if #available(iOS 15.0, *) {
            appearance.sectionHeaderTopPadding = 0
        }
        
    }
    
    /// 更新数据
    /// - Parameters:
    ///   - datas: 需要插入的数据
    ///   - toDatas: 被插入的数据源
    ///   - datasUpdate: 数据更新回调，ep：cellModels = datas
    func insert<Element>(datas: [Element]?, toDatas: [Element]?, datasUpdate: ((_ datas: [Element]?) -> Void)?) {
        
        let beginIndex = toDatas?.count ?? 0
        
        var tmpDatas = toDatas
        datas?.forEach { data in
            tmpDatas?.insert(data, at: 0)
        }
        
        datasUpdate?(tmpDatas)
        
        let dataCount = tmpDatas?.count ?? 0
        guard (tmpDatas?.isEmpty ?? true) == false, dataCount > beginIndex else {
            return
        }
        
        reloadData()
        
        guard beginIndex == 0 else {
            scrollToRow(at: IndexPath(row: dataCount-beginIndex, section: 0), at: .top, animated: false)
            return
        }
        
        if contentOffset.y != 0.0 {
            setContentOffset(CGPoint.zero, animated: false)
        }
        scrollToRow(at: IndexPath(row: dataCount-1, section: 0), at: .bottom, animated: false)
        
    }
}
