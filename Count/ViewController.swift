//
//  ViewController.swift
//  Count
//
//  Created by 竹村明日香 on 2021/05/28.
//


//数字四則演算は自由　誤差を小さくする


import UIKit
import Speech

class ViewController: UIViewController {
    
    var number: Int = 0
    
    let speechRecognizer: SFSpeechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ja-JP"))!
    let audioEngine: AVAudioEngine = AVAudioEngine()
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    
    //問題
    @IBOutlet var randomlabel: UILabel!
    
    //回答表示
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    
    var number1: Int?
    var number2: Int?
    var number3: Int?
    var number4: Int?
    

    let randomInt = Int.random(in: 4..<100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SFSpeechRecognizer.requestAuthorization { status in
            print("isAuthorized: \(status == .authorized)")
        }
    }
    
    
    @IBAction func Start(){
        try! startRecording()
    }
    
    // 音声認識の開始
    func startRecording() throws {
        
        let inputNode = audioEngine.inputNode
        let format = inputNode.inputFormat(forBus: 0)
        
        // マイクの入力受信
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, time in
            self.recognitionRequest?.append(buffer)
        }
        
        // 開始
        audioEngine.prepare()
        try audioEngine.start()
        
        setupSpeech()
    }
    
    // 音声→文字の処理
    func setupSpeech() {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("クラッシュ")
        }
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
            
            var isFinal = false
            
            if let result = result {
                // ラベルに文字起こしの結果を表示
                self.number1 = Int(result.bestTranscription.formattedString)
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                // エラーがある or 音声認識が終了した
                
                self.audioEngine.stop()
                self.audioEngine.inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        })
    }
    

}

