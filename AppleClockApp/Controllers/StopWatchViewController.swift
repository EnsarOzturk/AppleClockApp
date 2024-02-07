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
    @IBOutlet var refreshButton: UIButton!
    
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
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        
    }
    
    
    @objc func updateElapsedTime() {
        let currentTime = CACurrentMediaTime()
        let elapsedTime = currentTime - startTime
        updateStopWatch(elapsedTime)
     }
    
    func updateStopWatch(_ elapsedTime: CFTimeInterval) {
        let minute = Int(elapsedTime / 60)
        let second = Int(elapsedTime) % 60
        let milliSecond = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        let timeFormat = String(format: "%02d:%02d,%02d", minute, second, milliSecond)
        stopWatchLabel.text = timeFormat
    }
    
    @IBAction func roundButtonTapped(_ sender: UIButton) {
        let currentTime = CACurrentMediaTime()
        let elapsedTime = currentTime - startTime
        let minute = Int(elapsedTime / 60)
        let second = Int(elapsedTime) % 60
        let milliSecond = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        let timeFormat = String(format: "%02d:%02d,%02d", minute, second, milliSecond)
        roundTimes.insert(timeFormat, at: 0)
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.insertItems(at: [indexPath])
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    func resetStopWatch() {
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
        cell.updateRoundLabel(with: roundTimes[indexPath.item], roundNumber: roundTimes.count - indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = 70.0
        return  CGSize(width: width, height: height)
    }
}
