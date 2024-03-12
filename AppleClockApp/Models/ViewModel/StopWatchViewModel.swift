//
//  StopWatchViewModel.swift
//  AppleClockApp
//
//  Created by Ensar on 1.02.2024.
//

import Foundation
import QuartzCore

protocol StopWatchViewModelProtocol {
    var elapsedTime: CFTimeInterval { get }
    var isRunning: Bool { get }
    var roundTimes: [String] { get }
    
    func startStopWatch()
    func stopStopWatch()
    func resetStopWatch()
    func recordRoundTime()
    func formatElapsedTime(_ elapsedTime: CFTimeInterval) -> String
}

class StopWatchViewModel: StopWatchViewModelProtocol {
    private var startTime: CFTimeInterval = 0.0
    private var displayLink: CADisplayLink?
    private var _roundTimes: [String] = []
    
    var elapsedTime: CFTimeInterval {
        if let displayLink = displayLink {
            return CACurrentMediaTime() - startTime
        } else {
            return 0.0
        }
    }
    
    var isRunning: Bool {
        return displayLink != nil
    }
    
    var roundTimes: [String] {
        return _roundTimes
    }
    
    func startStopWatch() {
        if displayLink == nil {
            startTime = CACurrentMediaTime()
            displayLink = CADisplayLink(target: self, selector: #selector(updateElapsedTime))
            displayLink?.add(to: .main, forMode: .default)
        }
    }
    
    func stopStopWatch() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    func resetStopWatch() {
        stopStopWatch()
        _roundTimes.removeAll()
    }
    
    func recordRoundTime() {
        let timeFormat = formatElapsedTime(elapsedTime)
        _roundTimes.insert(timeFormat, at: 0)
    }
    
    @objc private func updateElapsedTime() {
        let currentTime = CACurrentMediaTime()
        let elapsedTime = currentTime - startTime
        print(formatElapsedTime(elapsedTime))
        
        NotificationCenter.default.post(name: NSNotification.Name("updateStopWatchLabel"), object: nil)
        
    }
    
     func formatElapsedTime(_ elapsedTime: CFTimeInterval) -> String {
        let minute = Int(elapsedTime / 60)
        let second = Int(elapsedTime) % 60
        let milliSecond = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d,%02d", minute, second, milliSecond)
    }
}
