//
//  ViewController.swift
//  CatchTheCandyGame1
//
//  Created by ELİF BEYZA SAĞLAM on 9.07.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hightScoreLabel: UILabel!
    
    @IBOutlet weak var candy1: UIImageView!
    @IBOutlet weak var candy2: UIImageView!
    @IBOutlet weak var candy3: UIImageView!
    @IBOutlet weak var candy4: UIImageView!
    @IBOutlet weak var candy5: UIImageView!
    @IBOutlet weak var candy6: UIImageView!
    @IBOutlet weak var candy7: UIImageView!
    @IBOutlet weak var candy8: UIImageView!
    @IBOutlet weak var candy9: UIImageView!
    
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var candyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        scoreLabel.text = "Score : \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
    
        if storedHighScore == nil {
            highScore = 0
            hightScoreLabel.text = "Highscore : \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
        highScore = newScore
            hightScoreLabel.text = "Highscore : \(highScore)"
        }
        
        
            candy1.isUserInteractionEnabled = true
            candy2.isUserInteractionEnabled = true
            candy3.isUserInteractionEnabled = true
            candy4.isUserInteractionEnabled = true
            candy5.isUserInteractionEnabled = true
            candy6.isUserInteractionEnabled = true
            candy7.isUserInteractionEnabled = true
            candy8.isUserInteractionEnabled = true
            candy9.isUserInteractionEnabled = true

      let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))


      candy1.addGestureRecognizer(recognizer1)
      candy2.addGestureRecognizer(recognizer2)
      candy3.addGestureRecognizer(recognizer3)
      candy4.addGestureRecognizer(recognizer4)
      candy5.addGestureRecognizer(recognizer5)
      candy6.addGestureRecognizer(recognizer6)
      candy7.addGestureRecognizer(recognizer7)
      candy8.addGestureRecognizer(recognizer8)
      candy9.addGestureRecognizer(recognizer9)


        candyArray = [candy1,candy2,candy3,candy4,candy5,candy6,candy7,candy8,candy9]
          
        


    counter = 10
    timeLabel.text = "\(counter)"
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)

        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideCandy), userInfo: nil, repeats: true)
        
        
   hideCandy()

  }


      @objc func hideCandy () {
       
      for candy in candyArray {
               candy.isHidden = true
  }
  
    let random = Int(arc4random_uniform(UInt32(candyArray.count - 1)))
        candyArray[random].isHidden = false
}

    @objc func  increaseScore(){
     score += 1
     scoreLabel.text = "Score : \(score)"

 }


     @objc func countDown () {

       counter -= 1
       timeLabel.text = "\(counter)"

   if counter == 0 {
       timer.invalidate()
       hideTimer.invalidate()
       
       for candy in candyArray {
           candy.isHidden = true
}

       if self.score > self.highScore {
       self.highScore = self.score
       hightScoreLabel.text = "Highscore: \(self.highScore)"
       UserDefaults.standard.set(self.highScore, forKey: "highscore")
                   }
       
 
       
    let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
    let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in

    
        self.score = 0
        self.scoreLabel.text = "Score: \(self.score)"
        self.counter = 10
        self.timeLabel.text = String(self.counter)
        
        
                        
    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
    self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideCandy), userInfo: nil, repeats: true)
    
    }
    alert.addAction(okButton)
    alert.addAction(replayButton)
    self.present(alert, animated: true, completion: nil)

}

}
}

    




