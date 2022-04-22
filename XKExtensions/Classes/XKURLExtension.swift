//
//  XKURLExtension.swift
//  XKExtensions
//
//  Created by kenneth on 2022/4/22.
//

import Foundation
import AVFoundation

public extension URL {
    
    // MARK: 网络视频尺寸
    func remoteVideoSize(maxHeight: CGFloat = UIScreen.main.bounds.width) -> CGSize {
            
        let asset = AVURLAsset(url: self)
        
        var videoSize = CGSize.zero
        
        for track in asset.tracks {
            
            if track.mediaType == .video {
                videoSize = track.naturalSize
            }
        }
        
        let convertHeight = videoSize == CGSize.zero ? 0.0 : UIScreen.main.bounds.width * videoSize.height / videoSize.width
        
        return CGSize(width: UIScreen.main.bounds.width, height: convertHeight > maxHeight ? maxHeight : convertHeight)
    }
    
}
