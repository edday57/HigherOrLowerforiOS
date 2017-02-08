//
//  ViewController.swift
//  test
//
//  Created by Edward Day on 03/02/2017.
//  Copyright © 2017 Edward Day. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var maxSlider: UISlider!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet weak var higherBtn: UIButton!
    @IBOutlet weak var lowerBtn: UIButton!
    @IBOutlet weak var progressRing: KDCircularProgress!
    @IBOutlet weak var currentNumber: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    
    @IBOutlet weak var highscoreLbl: UILabel!
    var modeMax = 55
    var score = 0
    var previousNumber:Int = 0
    var randomNumber = 5
    var highscore = 0
    
    override func viewDidLoad() {
        
        var highScoreDefault = UserDefaults.standard
        if highScoreDefault.value(forKey: "HighScore") == nil {
            highscore = 0
        } else {
            highscore = highScoreDefault.value(forKey: "HighScore") as! Int!
        }
        highscoreLbl.text = "Highscore: \(highscore)"
        
        progressRing.layer.shadowRadius = 20
        progressRing.layer.shadowColor = UIColor.white.cgColor
        progressRing.layer.shadowOpacity = 0.1
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        genNumber()
        updateScore()
        
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        modeMax = Int(sender.value)
        maxLbl.text = String(modeMax)
        score = 0

    }

    @IBAction func sliderStoppedInside(_ sender: Any) {
        updateScore()
        genNumber()
        previousNumber = randomNumber
    }
    
    @IBAction func sliderStoppedOutside(_ sender: Any) {
        updateScore()
        genNumber()
        previousNumber = randomNumber
        
    }
    

    
    func updateRing() {
        var progress:Double = Double(randomNumber) / Double(modeMax) * Double(270)

        progressRing.animate(toAngle: progress, duration: 0.5, completion: nil)
        
    }

    func genNumber() {
        randomNumber = Int(arc4random_uniform(UInt32(modeMax))) + 1
        currentNumber.text = String(randomNumber)
        updateRing()
    }

    func updateScore(){
        currentScore.text = "Current Score: \(score)"
    }
    
    @IBAction func lowerBtnTapped(_ sender: Any) {
        genNumber()
        if randomNumber <= previousNumber{
            score += 1
            if score > highscore {
                highscore = score
                highscoreLbl.text = "Highscore: \(highscore)"
                var highScoreDefault = UserDefaults.standard
                highScoreDefault.set(highscore, forKey: "HighScore")
                highScoreDefault.synchronize()
            }
            updateScore()
        }
        else {
            score = 0
            updateScore()
        }
        previousNumber = randomNumber
    }

    @IBAction func higherBtnTapped(_ sender: Any) {
        genNumber()
        if randomNumber >= previousNumber{
            score += 1
            if score > highscore {
                highscore = score
                highscoreLbl.text = "Highscore: \(highscore)"
                var highScoreDefault = UserDefaults.standard
                highScoreDefault.set(highscore, forKey: "HighScore")
                highScoreDefault.synchronize()
            }
            updateScore()
        }
        else {
            score = 0
            updateScore()
        }
        previousNumber = randomNumber
    }

}

