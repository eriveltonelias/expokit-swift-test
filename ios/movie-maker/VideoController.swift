//
//  VideController.swift
//  movie-maker
//
//  Created by Erivelton Elias on 3/25/18.
//  Copyright © 2018 650 Industries, Inc. All rights reserved.
//

import Foundation
import UIKit


@objc(VideoController)
class VideoController: UIViewController  {

    @objc func showVideo(_ text: String, callback: RCTResponseSenderBlock ) -> Void {
        
        let videoUrl = "http://d23dyxeqlo5psv.cloudfront.net/big_buck_bunny.mp4"
        
        let response:[String:Any] =  [ "video": videoUrl]
        
        print(" ------------------------------------------------ ")
        print(text)
        print("--------------------------------------------------")
        
        callback([response])
        
    }
    @objc func openNativeScreen() -> Void {
        
    }
}




