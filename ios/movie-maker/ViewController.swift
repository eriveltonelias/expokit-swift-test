//
//  ViewController.swift
//  Movie Maker
//
//  Created by Awais Hussain on 09/03/2018.
//  Copyright © 2018 Awais Hussain. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import AVKit
import AVFoundation
import MediaPlayer
import Photos

// Setup the view controller with the appropriate delegates
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVPlayerViewControllerDelegate, UITextViewDelegate {
    
    var editViewController: EditViewController?
    var mediaHandler = MediaHandler()
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    var image = UIImage()
    var player: AVPlayer?
    let playerController = CustomAVPlayerViewController()
    var mediapicker1: MPMediaPickerController!
    
    var videos: [URL] = []
    var videoURL: URL?
    var audioURL: URL?
    var currentVideo = 0
    
    @IBOutlet weak var addSongButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var v = UIView()
    var textView: UITextView? = nil
    
    var panGesture       = UIPanGestureRecognizer()
    var tapGesture       = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mediaHandler.prepare()
        
        
        
    }
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        self.mediaHandler.loadVideo(sender: self)
    }
    
    @IBAction func loadAudioButtonTapped(sender: UIButton) {
        self.present(mediapicker1, animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
    }
    
}

class CustomAVPlayerViewController: AVPlayerViewController {
    var parentVC: EditViewController? = nil
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        parentVC?.dismissTextView()
    }
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}





