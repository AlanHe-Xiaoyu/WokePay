//
//  ViewController.swift
//  WokePay
//
//  Created by zhou_rui on 11/3/18.
//  Copyright © 2018 Rui Zhou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, SwipeableCardViewDataSource {
    @IBOutlet var overview: StaticShadowHeaderView!
    
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overview.progress.setProgress(overview.progress.progress + 0.7, animated: true)
        swipeableCardView.dataSource = self
    }
    
}

// MARK: - SwipeableCardViewDataSource

extension HomeViewController {
    
    func numberOfCards() -> Int {
        return viewModels.count
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let viewModel = viewModels[index]
        let cardView = SampleSwipeableCard()
        cardView.viewModel = viewModel
        return cardView
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
    
}

extension HomeViewController {
    
    var viewModels: [SampleSwipeableCellViewModel] {
        
        let hamburger = SampleSwipeableCellViewModel(title: "McDonalds",
                                                     subtitle: "Hamburger",
                                                     color: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0),
                                                     image: #imageLiteral(resourceName: "hamburger"))
        
        let panda = SampleSwipeableCellViewModel(title: "Panda",
                                                 subtitle: "Animal",
                                                 color: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "panda"))
        
        let puppy = SampleSwipeableCellViewModel(title: "Puppy",
                                                 subtitle: "Pet",
                                                 color: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "puppy"))
        
        let poop = SampleSwipeableCellViewModel(title: "Poop",
                                                subtitle: "Smelly",
                                                color: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0),
                                                image: #imageLiteral(resourceName: "poop"))
        
        let robot = SampleSwipeableCellViewModel(title: "Robot",
                                                 subtitle: "Future",
                                                 color: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "robot"))
        
        let clown = SampleSwipeableCellViewModel(title: "Clown",
                                                 subtitle: "Scary",
                                                 color: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "clown"))
        
        return [hamburger, panda, puppy, poop, robot, clown]
    }
    
}

