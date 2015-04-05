//
//  RecordAudioViewController.swift
//  Pitch Perfect
//
//  Created by Don Esry on 3/5/15.
//  Copyright (c) 2015 Don Esry. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    //Declared Globally
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        showRecordingInstructions()
    }

    // show the recording instructions and buttons
    func showRecordingInstructions() {
        // hide the recording in progress
        recordingInProgress.hidden = true
        // show the tap to record label
        tapToRecord.hidden = false
        // hide the button to stop recording
        stopButton.hidden = true
        // enable the record button
        recordButton.enabled = true
    }
    
    // show recording in progress labels and buttons
    func showRecordingInProgress() {
        // show the label to indicate recording
        recordingInProgress.hidden = false
        // hide the tap to record label
        tapToRecord.hidden = true
        // show the stop button and disable the record button
        stopButton.hidden = false
        // disable the record button while recording
        recordButton.enabled = false
    }
    
    @IBAction func recordStop(sender: UIButton) {
        // stop recording
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        // hide the recording label
        showRecordingInstructions()
    }
    
    // record the audio
    @IBAction func recordAudio(sender: UIButton) {
        // show the label to indicate recording
        showRecordingInProgress()
        
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }

    // did it really record
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {

        if(flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("ERROR: Recording was not successful.")
            showRecordingInstructions()
        }
    }

    // pass the recorded audio handle to the next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "stopRecording" ) {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
}

