//
//  PurchaseCard.swift
//  WokePay
//
//  Created by zhou_rui on 11/4/18.
//  Copyright © 2018 Rui Zhou. All rights reserved.
//

import UIKit
import CoreMotion
import fluid_slider
class PurchaseCard: SwipeableCardViewCard {

    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var amount: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var merchant: UILabel!
    
    @IBOutlet private weak var imageBackgroundColorView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var backgroundContainerView: UIView!

    /// Core Motion Manager
    private let motionManager = CMMotionManager()
    
    /// Shadow View
    private weak var shadowView: UIView?
    
    /// Inner Margin
    private static let kInnerMargin: CGFloat = 20.0
    @IBOutlet var slider: Slider!
    var viewModel: PurchaseCardModel? {
        didSet {
            configure(forViewModel: viewModel)
            let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
            slider.attributedTextForFraction = { fraction in
                let formatter = NumberFormatter()
                formatter.maximumIntegerDigits = 3
                formatter.maximumFractionDigits = 0
                let string = formatter.string(from: (fraction * 500) as NSNumber) ?? ""
                return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
            }
            slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
            slider.setMaximumLabelAttributedText(NSAttributedString(string: "10", attributes: labelTextAttributes))
            slider.fraction = 0.5
            slider.shadowOffset = CGSize(width: 0, height: 10)
            slider.shadowBlur = 5
            slider.shadowColor = UIColor(white: 0, alpha: 0.1)
            slider.contentViewColor = UIColor(red: 78/255.0, green: 77/255.0, blue: 224/255.0, alpha: 1)
            slider.valueViewColor = .white
            
        }
    }
    
    private func configure(forViewModel viewModel: PurchaseCardModel?) {
        if let viewModel = viewModel {
            name.text = viewModel.name
            amount.text = viewModel.amount
            date.text = viewModel.date
            merchant.text = viewModel.merchant
            imageBackgroundColorView.backgroundColor = viewModel.color
            imageView.image = viewModel.image
            
            backgroundContainerView.layer.cornerRadius = 14.0
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureShadow()
        
    }
    
    // MARK: - Shadow
    
    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: SampleSwipeableCard.kInnerMargin,
                                              y: SampleSwipeableCard.kInnerMargin,
                                              width: bounds.width - (2 * SampleSwipeableCard.kInnerMargin),
                                              height: bounds.height - (2 * SampleSwipeableCard.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        
        // Roll/Pitch Dynamic Shadow
        //        if motionManager.isDeviceMotionAvailable {
        //            motionManager.deviceMotionUpdateInterval = 0.02
        //            motionManager.startDeviceMotionUpdates(to: .main, withHandler: { (motion, error) in
        //                if let motion = motion {
        //                    let pitch = motion.attitude.pitch * 10 // x-axis
        //                    let roll = motion.attitude.roll * 10 // y-axis
        //                    self.applyShadow(width: CGFloat(roll), height: CGFloat(pitch))
        //                }
        //            })
        //        }
        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0))
    }
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }


}
