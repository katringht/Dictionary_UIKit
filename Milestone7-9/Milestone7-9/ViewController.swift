//
//  ViewController.swift
//  Milestone7-9
//
//  Created by Ekaterina Tarasova on 27.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var wordLabel: UILabel!
    var levelLabel: UILabel!
    var lossLabel : UILabel!
    var letterButtons = [UIButton]()
    var words = "smt"
    var level = 0 {
        didSet {
            title = "Level: \(level + 1)"
        }
    }
    var wrong = 0 {
        didSet {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(wrong)/7")
            navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        //        title = "Level: \(level)"
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(wrong)/7")
        //        navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .center
        wordLabel.text = "???"
        wordLabel.font = UIFont.systemFont(ofSize: 45)
        view.addSubview(wordLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 700),
            buttonsView.heightAnchor.constraint(equalToConstant: 500),
            buttonsView.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 100),
            buttonsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 50),
            
        ])
        
        let width = 60
        let height = 50
        
        for row in 0..<7{
            for col in 0..<4{
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                
                letterButton.setTitle("", for: .normal)
                
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
            }
        }
        
        for (index, char) in "abcdefghijklmnopqrstuvwxyz".enumerated(){
            letterButtons[index].setTitle(String(char).uppercased(), for: .normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGame()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let btnTitle = sender.titleLabel?.text else {return}
        
        if words.contains(btnTitle.lowercased()){
            var parts = wordLabel.text?.map{$0.uppercased()}
            
            for (index, item) in words.enumerated(){
                if String(item) == btnTitle.lowercased(){
                    parts![index] = btnTitle.uppercased()
                }
            }
            
            wordLabel.text = parts?.joined()
            sender.isHidden = true
            
            if wordLabel.text?.lowercased() == words{
                level += 1
                wrong = 0
                loadLevel()
            }
            
        }else{
            wrong += 1
            sender.isHidden = true
        }
        
        if wrong == 7  {
            let ac = UIAlertController(title: "Ooopss! You lose(", message: "You can try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "START", style: .default){ [weak self] _ in
                self?.wrong = 0
                self?.loadLevel()
            })
            present(ac, animated: true)
        }
        
    }
    
    func newGame() {
        level = 0
        wrong = 0
        loadLevel()
    }
    
    func loadLevel() {
        if let url = Bundle.main.url(forResource: "list", withExtension: "txt"){
            if let contUrl = try? String(contentsOf: url){
                let parts = contUrl.components(separatedBy: "\n")
                words = parts[level]
                
                if level == 3{
                    let ac = UIAlertController(title: "EEEEPP", message: "3/3", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Restart", style: .default){[weak self] _ in
                        self?.newGame()
                        
                    })
                    present(ac, animated: true)
                }
                
            }
        }
        for btn in letterButtons{
            btn.isHidden = false
        }
        wordLabel.text = String.init(repeating: "?", count: words.count)
    }
    
}

