//
//  ViewController.swift
//  Project2
//
//  Created by Ekaterina Tarasova on 13.02.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var contries = [String]()
    var score = 0
    var correctAns = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contries += ["estonia", "france", "germany", "italy", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
        
        
    }

    func askQuestion(action: UIAlertAction!){
        contries.shuffle()
        
        correctAns = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: contries[0]), for: .normal)
        button2.setImage(UIImage(named: contries[1]), for: .normal)
        button3.setImage(UIImage(named: contries[2]), for: .normal)
        
//        title = contries[correctAns].uppercased()
        title = "Find \(contries[correctAns].uppercased()). Your score: \(score)"
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAns{
            title = "Congratulations"
            score += 1
            askQuestion(action: nil)
        }else{
            title = "Wrong"
            score -= 1
            askQuestion(action: nil)
            let aC = UIAlertController(title: title, message: "Wrong! This is \(contries[correctAns])", preferredStyle: .alert)
            
            aC.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present (aC, animated: true)
        }
        
        if score == 10 {
            let ac = UIAlertController(title: title, message: "Your score is 10", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Again", style: .default, handler: askQuestion))
            present (ac, animated: true)
            
            score = 0
        }
        
    }
    
}

