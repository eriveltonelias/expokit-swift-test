//
//  VideoManipulator.swift
//  Movie Maker
//
//  Created by Awais Hussain on 18/03/2018.
//  Copyright © 2018 Awais Hussain. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class VideoManipulator: NSObject {
    open class var current: VideoManipulator {
        struct Static {
            static var instance = VideoManipulator()
        }
        
        return Static.instance
    }
    
    
    open class func getVideo(fromVideos videos: [URL], audioURL: URL?, success: @escaping ((URL) -> Void), failure: @escaping ((Error) -> Void)) {
        if videos.count == 1 { // If there is only one video then simply start playing that single video
            success(videos[0])
        } else { // Other merge all the videos in the videos list
            
            /*
            VideoGenerator.mergeMovies(videoURLs: videos, andFileName: "merged", success: { (URL1) in
                if audioURL != nil { // If there has been an audio file selected merge this with the new merge video
                    VideoManipulator.mergeAudio(withVideoURL: URL1, andAudioURL: audioURL!, success: { (URL) in
                        success(URL)
                    }, failure: { (error) in
                        failure(error)
                    })
                } else { // Else start playing the merged video
                    success(URL1)
                }
            }) { (error) in
                print("ERROR!! : \(error)")
                failure(error)
            }
 */
        }
    }
    
    open class func mergeAudio(withVideoURL videoUrl: URL, andAudioURL audioURL: URL, success: @escaping ((URL) -> Void), failure: @escaping ((Error) -> Void)) {
        
        /*
        /// create a mutable composition
        let mixComposition = AVMutableComposition()
        
        /// create a video asset from the url and get the video time range
        let videoAsset = AVURLAsset(url: videoUrl, options: nil)
        let videoTimeRange = CMTimeRange(start: kCMTimeZero, duration: videoAsset.duration)
        
        /// add a video track to the composition
        let videoComposition = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        if let videoTrack = videoAsset.tracks(withMediaType: .video).first {
            do {
                /// try to insert the video time range into the composition
                try videoComposition?.insertTimeRange(videoTimeRange, of: videoTrack, at: kCMTimeZero)
            } catch {
                failure(error)
            }
            
            var duration = CMTime(seconds: 0, preferredTimescale: 1)
            
            /// add an audio track to the composition
            let audioCompositon = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
            
            /// for all audio files add the audio track and duration to the existing audio composition
            _ = CMTime(seconds: AVURLAsset(url: audioURL).duration.seconds, preferredTimescale: 1)
            
            let audioAsset = AVURLAsset(url: audioURL)
            let audioTimeRange = CMTimeRange(start: kCMTimeZero, duration: AVURLAsset(url: videoUrl).duration)
            
            let shouldAddAudioTrack = true
            
            if shouldAddAudioTrack {
                if let audioTrack = audioAsset.tracks(withMediaType: .audio).first {
                    do {
                        try audioCompositon?.insertTimeRange(audioTimeRange, of: audioTrack, at: duration)
                    } catch {
                        failure(error)
                    }
                }
            }
            
            duration = AVURLAsset(url: videoUrl).duration
            
            /// check if the documents folder is available
            if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                
                /// create a path to the video file
                let videoOutputURL = URL(fileURLWithPath: documentsPath).appendingPathComponent("merged.m4v")
                
                do {
                    /// delete an old duplicate file
                    try FileManager.default.removeItem(at: videoOutputURL)
                } catch { }
                
                /// try to start an export session and set the path and file type
                if let exportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality) {
                    exportSession.outputURL = videoOutputURL
                    exportSession.outputFileType = AVFileType.mp4
                    exportSession.shouldOptimizeForNetworkUse = true
                    
                    /// try to export the file and handle the status cases
                    exportSession.exportAsynchronously(completionHandler: {
                        switch exportSession.status {
                        case .failed:
                            if let _error = exportSession.error {
                                failure(_error)
                            }
                            
                        case .cancelled:
                            if let _error = exportSession.error {
                                failure(_error)
                            }
                            
                        default:
                            let testMovieOutPutPath = URL(fileURLWithPath: documentsPath).appendingPathComponent("test.m4v")
                            
                            do {
                                try FileManager.default.removeItem(at: testMovieOutPutPath)
                            } catch { }
                            
                            success(videoOutputURL)
                        }
                    })
                } else {
                    
                }
            } else {
                
            }
        } else {
            
        }
 */
    }
    
    open class func addViewToVideo(url: URL, fileName: String, v: UIView, success: @escaping ((URL) -> Void), failure: @escaping ((Error) -> Void)) {
        /*
        let _fileName = fileName == "" ? "mergedMovie" : fileName
        var completeMoviePath: URL?
        do {
            let composition = AVMutableComposition()
            let vidAsset = AVURLAsset(url: url)
            
            // get video track
            let videoTrack = vidAsset.tracks(withMediaType: AVMediaType.video)[0]
            let duration = vidAsset.duration
            let vid_timerange = CMTimeRangeMake(kCMTimeZero, duration)
            let size = videoTrack.naturalSize
            // Due to the 90 deg rotation
            let width = size.width
            let height = size.height
            
            
            let compositionvideoTrack:AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: CMPersistentTrackID())!
            
            try compositionvideoTrack.insertTimeRange(vid_timerange, of: videoTrack, at: kCMTimeZero)
            compositionvideoTrack.preferredTransform = videoTrack.preferredTransform
            // Watermark Effect
            
            
            // Set up layers
            let imglayer = getImageLayer(width: width, v: v)
            imglayer.frame.origin.y = height-v.frame.origin.y
//            var v = UIView()
            
            
            // Original video from frontal camera.
            let videolayer = CALayer()
            videolayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
            videolayer.opacity = 1.0
            
            // Low fps Frames from the game.
            //            let overlayLayer = CALayer()
            //            overlayLayer.contents = self.v
            //            overlayLayer.add(
            //                getFramesAnimation(frames: [UIImage.init(view: self.v)], duration: vidAsset.duration.seconds), forKey: nil)
            //            overlayLayer.frame = CGRect(
            //                x: 0, y: 10, width: newWidth, height: newHeight)
            
            
            // Combine layers
            let parentlayer = CALayer()
            parentlayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
            parentlayer.addSublayer(videolayer)
            //            parentlayer.addSublayer(overlayLayer)
            parentlayer.addSublayer(imglayer)
            
            let layercomposition = AVMutableVideoComposition()
            layercomposition.frameDuration = CMTimeMake(1, 30)
            layercomposition.renderScale = 1.0
            layercomposition.renderSize = CGSize(width: size.width, height: size.height)
            
            // Enable animation for video layers
            layercomposition.animationTool = AVVideoCompositionCoreAnimationTool(
                postProcessingAsVideoLayers: [videolayer], in: parentlayer)
            
            // instruction for watermark
            let instruction = AVMutableVideoCompositionInstruction()
            instruction.timeRange = CMTimeRangeMake(kCMTimeZero, composition.duration)
            let videotrack = composition.tracks(withMediaType: AVMediaType.video)[0] as AVAssetTrack
            let layerinstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videotrack)
            instruction.layerInstructions = (NSArray(object: layerinstruction) as! [AVVideoCompositionLayerInstruction])
            layercomposition.instructions = NSArray(object: instruction) as! [AVVideoCompositionInstructionProtocol]
            
            //            let instruction = AVMutableVideoCompositionInstruction()
            //            instruction.timeRange = CMTimeRangeMake(kCMTimeZero, composition.duration)
            //            let layerinstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
            //            layerinstruction.setTransform(videoTrack.preferredTransform, at: kCMTimeZero)
            //            instruction.layerInstructions = [layerinstruction] as [AVVideoCompositionLayerInstruction]
            //            layercomposition.instructions = [instruction] as [AVVideoCompositionInstructionProtocol]
            
            // Add audio track.
            addAudioTrack(composition: composition, videoAsset: vidAsset)
            
            if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                /// create a path to the video file
                completeMoviePath = URL(fileURLWithPath: documentsPath).appendingPathComponent("\(_fileName).m4v")
            } else {
                
            }
            
            // Clear url.
            try? FileManager().removeItem(at: completeMoviePath!)
            
            
            // Use AVAssetExportSession to export video
            let assetExport = AVAssetExportSession(asset: composition, presetName:AVAssetExportPresetHighestQuality)
            assetExport?.outputFileType = AVFileType.m4v
            assetExport?.outputURL = completeMoviePath
            assetExport?.videoComposition = layercomposition
            
            assetExport?.exportAsynchronously(completionHandler: {
                switch assetExport!.status {
                case AVAssetExportSessionStatus.failed:
                    print("failed")
                    print(assetExport?.error ?? "unknown error")
                case AVAssetExportSessionStatus.cancelled:
                    print("cancelled")
                    print(assetExport?.error ?? "unknown error")
                default:
                    print("Movie complete")
                    success(completeMoviePath!)
                }
            })
            
        }catch {
            print("VideoWatermarker->getoverlayLayer everything is baaaad =(")
        }
 
 */
        
    }
    
    open class func getImageLayer(width: CGFloat, v: UIView) -> Void {
        /*
        let imglogo = UIImage.init(view: v)
        
        let imglayer = CALayer()
        imglayer.contents = imglogo.cgImage
        
        let aspectRatio: CGFloat = CGFloat(imglogo.cgImage!.height) / CGFloat(imglogo.cgImage!.width)
        imglayer.frame = CGRect(
            x: 0, y: 100,
            width: width, height: width*aspectRatio)
        
        return imglayer
 */
    }
    
    
    open class func getFramesAnimation(frames: [UIImage], duration: CFTimeInterval) -> Void {
        
        /*
        let animation = CAKeyframeAnimation(keyPath:#keyPath(CALayer.contents))
        animation.calculationMode = kCAAnimationDiscrete
        animation.duration = duration
        animation.values = frames.map {$0.cgImage!}
        animation.repeatCount = Float(frames.count)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.beginTime = AVCoreAnimationBeginTimeAtZero
        
        return animation
 */
    }
    
}
