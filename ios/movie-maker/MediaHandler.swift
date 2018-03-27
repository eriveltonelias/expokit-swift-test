//
//  MediaHandler.swift
//  Movie Maker
//
//  Created by Awais Hussain on 18/03/2018.
//  Copyright © 2018 Awais Hussain. All rights reserved.
//

import Foundation
import MobileCoreServices
import AssetsLibrary
import MediaPlayer
import Photos

class MediaHandler: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MPMediaPickerControllerDelegate {
    let imagePicker = UIImagePickerController()
    var mediapicker: MPMediaPickerController!
    var vc: ViewController? = nil
    var evc: EditViewController? = nil
    
    func prepare() {
        imagePicker.delegate = self
        let mediaPicker: MPMediaPickerController = MPMediaPickerController.self(mediaTypes:MPMediaType.music)
        mediaPicker.allowsPickingMultipleItems = false
        mediapicker = mediaPicker
        mediapicker.delegate = self
    }
    
    func loadVideo(sender: AnyObject) {
        // Checks if the Saved Photos Album is available to access
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            // Sets up and presents the UIImagePickerController
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.videoMaximumDuration = 10.0
            if let vcNew = sender as? ViewController {
                vc = vcNew
                evc = nil
                vc!.present(imagePicker, animated: true, completion: nil)
            } else if let evcNew = sender as? EditViewController {
                evc = evcNew
                vc = nil
                evc!.present(imagePicker, animated: true, completion: nil)
            }
            
        }
        else {
            print("Saved Photos Album is not available")
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        // 1
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
        
        // Does the checks to see if the video is able to be selected
        if let type:AnyObject = mediaType {
            if type is String {
                let stringType = type as! String
                if stringType == kUTTypeMovie as String {
                    // Gets the NSURL for the video
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? NSURL
                    if let url = urlOfVideo {
                        picker.dismiss(animated: true, completion: nil)
                        if evc == nil {
                            evc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as? EditViewController
                            evc!.videos = [url as URL]
                            vc!.present(evc!, animated: true, completion: nil)
                        } else {
                            evc!.videos.append(url as URL)
                        }
                        
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        guard let mediaItem = mediaItemCollection.items.first else {
            NSLog("No item selected.")
            let alert = UIAlertController(title: "Audio file is not available to use", message: "This could be due to the audio file not being downlaoded onto the device. Try downloading it from the Music app or try a different song.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            evc!.present(alert, animated: true, completion: nil)
            return
        }
        guard let songUrl = mediaItem.assetURL else {
            print("The audio file is not available.")
            let alert = UIAlertController(title: "Audio file is not available to use", message: "This could be due to the audio file not being downlaoded onto the device. Try downloading it from the Music app or try a different song.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            evc!.present(alert, animated: true, completion: nil)
            return
        }
        print(songUrl)
        evc!.audioURL = songUrl
        
        if (evc!.videoURL != nil) {
            // Add the audio file over the video file
            /*
            VideoManipulator.mergeAudio(withVideoURL: evc!.videoURL!, andAudioURL: evc!.audioURL!, success: { (videoURL) in
                print("finished audio")
                self.evc!.videoURL = videoURL
                //self.evc!.startPlayingVideo()
            }, failure: { (error) in
                
            })
 */
            
            self.mediapicker.dismiss(animated: true, completion: nil)
        } else {
            print("Null")
        }
        
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        print("clockes")
        self.mediapicker.dismiss(animated: true, completion: nil)
    }
    
}
