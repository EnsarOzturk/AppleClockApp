//
//  StopWatchViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 26.01.2024.
//

import UIKit

class StopWatchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var notificationObserver: NSObjectProtocol?
    @IBOutlet var stopWatchLabel: UILabel!
    @IBOutlet var roundButton: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopWatchView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var refreshButton: UIButton!
    var viewModel: StopWatchViewModelProtocol = StopWatchViewModel()

      override func viewDidLoad() {
          super.viewDidLoad()
          
          collectionView.dataSource = self
          collectionView.delegate = self
          collectionView.register(UINib(nibName: "StopWatchListCell", bundle: nil), forCellWithReuseIdentifier: "StopWatchListCell")
          view.backgroundColor = UIColor(named: "cellBackgroundColor")
          roundButton.layer.cornerRadius = 0.5 * roundButton.bounds.size.width
          roundButton.backgroundColor = UIColor(named: "roundButtonColor")
          roundButton.setTitleColor(UIColor(named: "roundButtonTitleColor"), for: .normal)
          startButton.backgroundColor = UIColor(named: "startButtonColor")
          startButton.setTitleColor(UIColor(named: "startButtonTitleColor"), for: .normal)
          startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
          stopWatchLabel.textColor = UIColor(named: "titleColor")
          stopWatchView.backgroundColor = UIColor(named: "stopWatchViewColor")
          collectionView.backgroundColor = UIColor(named: "cellBackgroundColor")
          refreshButton.layer.cornerRadius = 0.5 * refreshButton.bounds.size.width
          updateStopWatchLabel()
          notificationObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name("updateStopWatchLabel"), object: nil, queue: OperationQueue.main) { [weak self] _ in
                     self?.updateStopWatchLabel()
          }
      }
    
    func updateStopWatchLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let elapsedTime = self.viewModel.elapsedTime
            self.stopWatchLabel.text = self.viewModel.formatElapsedTime(elapsedTime)
        }
    }
      
      @IBAction func startButtonTapped(_ sender: UIButton) {
          if viewModel.isRunning {
              viewModel.stopStopWatch()
              sender.setTitle("Start", for: .normal)
              sender.setTitleColor(UIColor(named: "startButtonTitleColor"), for: .normal)
              sender.backgroundColor = UIColor(named: "startButtonColor")
              refreshButton.isHidden = true
          } else {
              viewModel.startStopWatch()
              sender.setTitle("Stop", for: .normal)
              sender.setTitleColor(UIColor(named: "stopButtonTitleColor"), for: .normal)
              sender.backgroundColor = UIColor(named: "stopButtonColor")
              refreshButton.isHidden = false
          }
      }
      
      @IBAction func refreshButtonTapped(_ sender: UIButton) {
          viewModel.resetStopWatch()
      }
      
      @IBAction func roundButtonTapped(_ sender: UIButton) {
          viewModel.recordRoundTime()
          collectionView.reloadData()
          collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
      }
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel.roundTimes.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StopWatchListCell", for: indexPath) as! StopWatchListCell
          cell.updateRoundLabel(with: viewModel.roundTimes[indexPath.item], roundNumber: viewModel.roundTimes.count - indexPath.item)
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = UIScreen.main.bounds.width
          let height = 70.0
          return  CGSize(width: width, height: CGFloat(height))
      }
  }
