//
//  UnratedPurchaseVC.swift
//  WokePay
//
//  Created by zhou_rui on 11/4/18.
//  Copyright © 2018 Rui Zhou. All rights reserved.
//

import UIKit
import fluid_slider

class UnratedPurchaseVC: UIViewController, SwipeableCardViewDataSource {
    func viewForEmptyCards() -> UIView? {
        return UIView()
    }
    
    
    @IBOutlet var cards: SwipeableCardViewContainer!
    override func viewDidLoad() {
        super.viewDidLoad()
        cards.dataSource = self
       
        let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        
        /*
        let slider = Slider()
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 500) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "500", attributes: labelTextAttributes))
        slider.fraction = 0.5
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor(red: 78/255.0, green: 77/255.0, blue: 224/255.0, alpha: 1)
        slider.valueViewColor = .white
        
        slider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        slider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
        }
        */
        
    }
    
}

extension UnratedPurchaseVC {
    
    func numberOfCards() -> Int {
        return viewModels.count
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let viewModel = viewModels[index]
        let cardView = PurchaseCard()
        
        cardView.slider?.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 500) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
        cardView.slider?.setMinimumLabelAttributedText(NSAttributedString(string: "1"))
        cardView.slider?.setMaximumLabelAttributedText(NSAttributedString(string: "100"))
        cardView.slider?.fraction = 0.5
        cardView.slider?.shadowOffset = CGSize(width: 0, height: 10)
        cardView.slider?.shadowBlur = 5
        cardView.slider?.shadowColor = UIColor(white: 0, alpha: 0.1)
        cardView.slider?.contentViewColor = UIColor(red: 78/255.0, green: 77/255.0, blue: 224/255.0, alpha: 1)
        cardView.slider?.valueViewColor = .white
        
        view.addSubview(cardView.slider)
        //cardView.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        cardView.viewModel = viewModel
        return cardView
    }
    
}

extension UnratedPurchaseVC {
    
    var viewModels: [PurchaseCardModel] {
        let a = PurchaseCardModel(name: "Burger",amount: "$8.60",date:"Nov 3, 2018",merchant:"Super Duper", color: UIColor.white,image: #imageLiteral(resourceName: "hamburger"))
        let b = PurchaseCardModel(name: "Metro",amount: "$2.50",date:"Nov 2, 2018",merchant:"NY Metro", color: UIColor.white,image: #imageLiteral(resourceName: "subway"))
        let c = PurchaseCardModel(name: "AA",amount: "$500",date:"Nov 4, 2018", merchant:"Saks Fifth Avenue", color: UIColor.white,image: #imageLiteral(resourceName: "hamburger"))
        return [a,b,c]
    }
}


