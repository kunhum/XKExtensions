//
//  XKPhotoExtension.swift
//  XKExtensions
//
//  Created by Kenneth Tse on 2026/2/4.
//

import Foundation
import PhotosUI

@available(iOS 14, *)
public extension PHPickerResult {
    func loadUIImage(completion: @escaping (UIImage?) -> Void) {
        guard itemProvider.canLoadObject(ofClass: UIImage.self) else {
            completion(nil)
            return
        }
        itemProvider.loadObject(ofClass: UIImage.self) { object, error in
            DispatchQueue.main.async {
                completion(object as? UIImage)
            }
        }
    }
}

@available(iOS 14, *)
public extension PHPickerViewController {
    static func picker(limit: Int = 3,
                       filter: PHPickerFilter = .images,
                       selectedIds: [String] = [],
                       delegate: (any PHPickerViewControllerDelegate)?) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = limit
        config.filter = filter
        config.preselectedAssetIdentifiers = selectedIds
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = delegate
        return picker
    }
}


