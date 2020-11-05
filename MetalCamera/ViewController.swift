//
//  ViewController.swift
//  MetalCamera
//
//  Created by com on 11/5/20.
//

import UIKit
import AVFoundation
import CoreMedia


class ViewController: UIViewController {

    @IBOutlet weak var metalView: MetalView!
    private var videoCapture: VideoCapture!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCamera()
    }
    
    private func setUpCamera() {
        videoCapture = VideoCapture()
        videoCapture.delegate = self
        videoCapture.setUp(sessionPreset: AVCaptureSession.Preset.hd1280x720, frameRate: 60) { success in
            if success {
                self.videoCapture.start()
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension ViewController: VideoCaptureDelegate {
    
    func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?, timestamp: CMTime) {
        
        DispatchQueue.main.async {
            self.metalView.pixelBuffer = pixelBuffer
        }
    }
}

