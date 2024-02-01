//
//  StopWatchViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 26.01.2024.
//

import UIKit

class StopWatchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var stopWatchLabel: UILabel!
    @IBOutlet var roundButton: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopWatchView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    var displayLink: CADisplayLink?
    var startTime: CFTimeInterval = 0.0
    var roundTimes: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "StopWatchListCell", bundle: nil), forCellWithReuseIdentifier: "StopWatchListCell")
        view.backgroundColor = UIColor(name: .cellBackgroundColor)
        roundButton.layer.cornerRadius = 0.5 * roundButton.bounds.size.width
        roundButton.backgroundColor = UIColor(name: .roundButtonColor)
        roundButton.titleLabel?.textColor = UIColor(name: .roundButtonTitleColor)
        startButton.backgroundColor = UIColor(name: .startButtonColor)
        startButton.titleLabel?.textColor = UIColor(name: .startButtonTitleColor)
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
        stopWatchLabel.textColor = UIColor(name: .titleColor)
        stopWatchView.backgroundColor = UIColor(name: .stopWatchViewColor)
        collectionView.backgroundColor = UIColor(name:  .cellBackgroundColor)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if displayLink == nil {
              startTime = CACurrentMediaTime()
              displayLink = CADisplayLink(target: self, selector: #selector(updateElapsedTime))
              displayLink?.add(to: .main, forMode: .default)
              sender.setTitle("Stop", for: .normal)
            sender.setTitleColor(UIColor(name: .stopButtonTitleColor), for: .normal) 
            sender.backgroundColor = UIColor(name: .stopButtonColor)
          } else {
              displayLink?.invalidate()
              displayLink = nil
              sender.setTitle("Start", for: .normal)
              sender.setTitleColor(UIColor(name: .startButtonTitleColor), for: .normal)
              sender.backgroundColor = UIColor(name: .startButtonColor)
          }
    }
    
    @objc func updateElapsedTime() {
        let currentTime = CACurrentMediaTime()
        let elapsedTime = currentTime - startTime
        kronometreEtiketiniGüncelle(elapsedTime)
     }
    
        func kronometreEtiketiniGüncelle(_ elapsedTime: CFTimeInterval) {
                let dakika = Int(elapsedTime / 60)
                let saniye = Int(elapsedTime) % 60
                let salise = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
                
                let biçimliZaman = String(format: "%02d:%02d,%02d", dakika, saniye, salise)
                stopWatchLabel.text = biçimliZaman
        }
    
    @IBAction func roundButtonTapped(_ sender: UIButton) {
        let currentTime = CACurrentMediaTime()
          let elapsedTime = currentTime - startTime
          let dakika = Int(elapsedTime / 60)
          let saniye = Int(elapsedTime) % 60
          let salise = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
          let biçimliZaman = String(format: "%02d:%02d,%02d", dakika, saniye, salise)
          roundTimes.append(biçimliZaman)
        roundTimes.reverse()
          collectionView.reloadData()
    }
    
    func resetChronometer() {
        displayLink?.invalidate()
        displayLink = nil
        stopWatchLabel.text = "00:00,00"
        roundTimes.removeAll()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        roundTimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StopWatchListCell", for: indexPath) as! StopWatchListCell
        cell.updateRoundLabel(with: roundTimes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = 80.0
        
        return  CGSize(width: width, height: height)
    }
}
