//
//  ViewController.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 07..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var vsHumanView: VersusView!
    @IBOutlet weak var vsElfView: VersusView!
    @IBOutlet weak var vsOrcView: VersusView!
    @IBOutlet weak var vsUndeadView: VersusView!
    
    var player = "player"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

}

