//
//  EditViewController.swift
//  Movie Maker
//
//  Created by Awais Hussain on 18/03/2018.
//  Copyright © 2018 Awais Hussain. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import Photos


class EditViewController: UIViewController, UITextViewDelegate {
    var videoURL: URL?
    var videos: [URL] = []
    var audioURL: URL?
    var currentVideo = 0
    
    var v = UIView()
    var textView: UITextView? = nil
    
    var panGesture = UIPanGestureRecognizer()
    var tapGesture = UITapGestureRecognizer()
    
    var player: AVPlayer?
    let playerController = CustomAVPlayerViewController()
    
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var addMusicButton: UIButton!
    @IBOutlet weak var addVideoButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func closeButtonTapped(sender: UIButton) {
        (self.presentingViewController as! ViewController).editViewController = nil
        player!.pause()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMusicButtonTapped(sender: UIButton) {
        self.present((self.presentingViewController as! ViewController).mediaHandler.mediapicker, animated: true, completion: nil)
    }
    
    @IBAction func addVideoButtonTapped(sender: UIButton) {
        (self.presentingViewController as! ViewController).mediaHandler.loadVideo(sender: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadVideos()
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
    }
    
    func loadVideos() {
        print(videos)
        /*
        VideoManipulator.getVideo(fromVideos: videos, audioURL: audioURL, success: { (URLNew) in
            self.videoURL = URLNew
            /*
            DispatchQueue.main.async {
                self.startPlayingVideo()
            }*/
            
            
        }, failure: { (error) in
            print(error)
        })
 */
    }
    
    
    var keyboardHeight: CGFloat = 0.0
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            self.v.frame.origin.y = self.playerController.view.frame.height-keyboardHeight-self.v.frame.height
        }
    }
    
    var previousHeight: CGFloat = 0.0
    func textViewDidChange(_ textView: UITextView) {
        let contentSize = textView.sizeThatFits(textView.bounds.size)
        if (previousHeight != contentSize.height) {
            textView.frame.size.height = contentSize.height
            self.v.frame.size.height = contentSize.height
            self.v.frame.origin.y = self.playerController.view.frame.height-keyboardHeight-self.v.frame.height
            previousHeight = contentSize.height
        }
        
    }
    
    @objc func dismissTextView() {
        print("Touched view")
        if self.textView != nil && self.textView!.isFirstResponder {
            self.textView!.endEditing(true)
            if self.textView!.text == "" {
                self.v.removeFromSuperview()
                self.textView = nil
            }
        } else if self.textView == nil {
            self.v = UIView(frame: CGRect(x: 0, y: self.playerController.view.frame.height*0.3, width: self.playerController.view.frame.width, height: 35))
            self.v.backgroundColor = UIColor.black
            self.v.alpha = 0.7
            
            self.textView = UITextView(frame: CGRect(x: 0, y: 0, width: v.frame.width, height: v.frame.height))
            self.textView!.delegate = self
            self.textView!.font = UIFont.systemFont(ofSize: 17.0)
            self.v.addSubview(textView!)
            self.textView!.textAlignment = .center
            self.textView!.backgroundColor = UIColor.clear
            self.textView!.textColor = UIColor.white
            self.textView!.isScrollEnabled = false
            
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
            self.v.isUserInteractionEnabled = true
            self.v.addGestureRecognizer(panGesture)
            
            
            
            self.playerController.view.addSubview(self.v)
            self.textView!.becomeFirstResponder()
        }
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: playerController.view)
        self.v.center = CGPoint(x: self.v.center.x, y: self.v.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: playerController.view)
    }
    
}
