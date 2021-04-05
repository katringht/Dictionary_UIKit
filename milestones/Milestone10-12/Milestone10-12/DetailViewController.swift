//
//  DetailViewController.swift
//  Milestone10-12
//
//  Created by Ekaterina Tarasova on 08.03.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedPhoto: Photos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(String(describing: selectedPhoto!.name))"
        
        if let photoToLoad = selectedPhoto?.image {
//            print(selectedPhoto?.image)
//            print(photoToLoad)
            imageView.image = UIImage(named: photoToLoad)
        } else {
            fatalError("Cannot find photoToLoad")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
