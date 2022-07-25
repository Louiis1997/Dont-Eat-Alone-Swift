//
//  MatchViewController.swift
//  Don't eat alone
//
//  Created by Luigi on 25/07/2022.
//

import UIKit

class MatchViewController: UIViewController {
    @IBOutlet weak var card: UIImageView!
    
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var ville: UILabel!
    @IBOutlet weak var distance: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeLeft = UISwipeGestureRecognizer(target:card,action: Selector(("swipeLeftEvent")))
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: card, action: Selector(("swipeRightEvent")))
        swipeRight.direction = .right
        // Do any additional setup after loading the view.
    }
    
    func swipeLeftEvent(){
        nom.text = "Gauche"
    }
    
    func swipeRightEvent(){
        nom.text = "Right"
    }
}
