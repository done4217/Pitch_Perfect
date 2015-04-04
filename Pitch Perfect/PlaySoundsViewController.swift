//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Don Esry on 3/17/15.
//  Copyright (c) 2015 Don Esry. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    @IBOutlet weak var SnailSoundButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var tunerSlider: UISlider!
    @IBOutlet weak var tuneAudioLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    
    var audioFile: AVAudioFile!
    
    var adjustment:Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

    }

    override func viewWillAppear(animated: Bool) {
        showTunerHideStop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func playSnailSlow(sender: UIButton) {
        // play the audio
        playAudioAtRate( 0.7 )
    }

    @IBAction func playRabbitFast(sender: UIButton) {
        // play the audio
        playAudioAtRate( 1.7 )
    }

    func stopAndReset() {
        // stop in case it was playing already
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func showStopHideTuner() {
        // show the stop button
        stopButton.hidden = false
        // hide the tuner slider and label
        tunerSlider.hidden = true
        tuneAudioLabel.hidden = true
    }

    func showTunerHideStop() {
        stopButton.hidden = true
        tunerSlider.hidden = false
        tuneAudioLabel.hidden = false
        
    }
    
    // play the audio at the desired rate
    func playAudioAtRate(targetRate: Float) {
        // stop in case it was playing already
        stopAndReset()
        
        // set up the player
        audioPlayer.rate = targetRate
        audioPlayer.currentTime = 0.0
        
        // play the audio
        audioPlayer.play()
        
        showStopHideTuner()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        // pitch range is -2400 to 2400
        var basepitch = Float( 950 )
        
        // let user tune it +/- 300
        var tuneadjustment = Float(0)
        if ( adjustment > 0.01 ) {
            tuneadjustment = Float( 300 ) * adjustment
        }
        
        var tunedvalue = Float(basepitch + tuneadjustment )
        playAudioWithVariablePitch( tunedvalue )
        
    }
 
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        // pitch range is -2400 to 2400
        var basepitch = Float( -1050 )
        
        // let user tune it +/- 300
        var tuneadjustment = Float(0)
        if ( adjustment > 0.01 ) {
            tuneadjustment = Float( 300 ) * adjustment
        }
        
        var tunedvalue = Float(basepitch + tuneadjustment )
        playAudioWithVariablePitch( tunedvalue )
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        // stop any playing that might be happening
        stopAndReset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        // pitch range -2400 to 2400
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()

        showStopHideTuner()
    }
    
    @IBAction func tunerSlider(sender: UISlider) {
        adjustment = Float( sender.value )
    }
    
    @IBAction func stopHalt(sender: UIButton) {
        // stop any playing that might be happening
        stopAndReset()
        
        showTunerHideStop()
    }
}
