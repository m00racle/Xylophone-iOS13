//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func keyPressed(_ sender: UIButton) {
        let buttonTitle = sender.titleLabel?.text ?? "nil"
//        print(buttonTitle)
//        make the button opacity to 0.5
        sender.alpha=0.5
//        after certain time the button alpha must back to normal (1.0)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            UIView.animate(withDuration: 0.2) {
                sender.alpha=1.0
            }
            
        }
        playSound(buttonNote:buttonTitle)
    }
    
    var player:AVAudioPlayer? //set variable named player (type of AVAudioPlayer)
    
    func playSound(buttonNote:String) {
        guard let url = Bundle.main.url(forResource: buttonNote, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    

}

