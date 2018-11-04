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
    
    @IBOutlet var worthCards: SwipeableCardViewContainer!
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    var renderer2: CardRenderer2!
    override func viewDidLoad() {
        super.viewDidLoad()
        overview.progress.setProgress(overview.progress.progress + 0.7, animated: true)
        swipeableCardView.dataSource = self
        renderer2 = CardRenderer2()
        worthCards.dataSource = renderer2
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
class CardRenderer2: NSObject, SwipeableCardViewDataSource {
    
}

extension CardRenderer2 {
    
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
        
        let hamburger = SampleSwipeableCellViewModel(title: "Entertainment",
                                                     color: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0),
                                                     image: #imageLiteral(resourceName: "hamburger"))
        
        let panda = SampleSwipeableCellViewModel(title: "Shopping",
                                                 color: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "panda"))
        
        let puppy = SampleSwipeableCellViewModel(title: "Food",
                                                 color: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "puppy"))
        
        return [hamburger, panda, puppy]
    }
}

extension CardRenderer2 {
    
    var viewModels: [SampleSwipeableCellViewModel] {
        
        
        let poop = SampleSwipeableCellViewModel(title: "Transport",
                                                color: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0),
                                                image: #imageLiteral(resourceName: "poop"))
        
        let robot = SampleSwipeableCellViewModel(title: "Education",
                                                 color: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "robot"))
        
        let clown = SampleSwipeableCellViewModel(title: "Health",
                                                 color: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "clown"))
        
        return [poop, robot, clown]
    }
    
}

