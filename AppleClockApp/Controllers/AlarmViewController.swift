//
//  AlarmViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 31.01.2024.
//

import UIKit
import AVFoundation

class AlarmViewController: UIViewController {
    @IBOutlet var alarmLabel: UILabel!
    @IBOutlet var closeButton: UIButton!
    var alarmTime: String?
    var isAlarmOn: Bool = false
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
           if let alarmTime = alarmTime {
               alarmLabel.text = "Alarm Time: \(alarmTime)"
           }
       }
    
    func playAlarmSound() {
          guard let soundURL = Bundle.main.url(forResource: "AlarmSound", withExtension: "mp3") else {
              return
          }
          do {
              player = try AVAudioPlayer(contentsOf: soundURL)
              player?.numberOfLoops = -1  // Repeat indefinitely
              player?.play()
          } catch {
              print("Error playing alarm sound: \(error.localizedDescription)")
          }
      }
    
    func stopAlarm() {
          player?.stop()
      }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        stopAlarm()
    }
    
}
