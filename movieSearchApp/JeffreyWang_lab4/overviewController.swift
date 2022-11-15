//
//  overviewController.swift
//  JeffreyWang_lab4
//
//  Created by Ziqian Wang on 10/30/22.
//

import Foundation
import UIKit
import AVFoundation

class overviewController: UIViewController{
    
    var overviewContent:String?
    var utterance:AVSpeechUtterance?
    var synthesizer:AVSpeechSynthesizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewText.text = overviewContent
    }
    
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var readBtn: UIButton!
    
    @IBAction func speechBtn(_ sender: UIButton) {
        
        synthesizer?.stopSpeaking(at: AVSpeechBoundary.immediate)
        
        let ut = AVSpeechUtterance(string:"no overview content found")
        
        utterance = AVSpeechUtterance(string: overviewContent ?? "no overview content found")
        utterance!.voice = AVSpeechSynthesisVoice(language:"en")
        utterance!.rate = 0.5
        
        synthesizer = AVSpeechSynthesizer()
        synthesizer!.speak(utterance ?? ut)
        
        }
    
    @IBAction func pauseBtnpressed(_ sender: UIButton) {
        
        synthesizer?.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    
}
