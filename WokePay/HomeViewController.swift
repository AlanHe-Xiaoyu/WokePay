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
    
    public var chartType: AAChartType? = AAChartType.column
    public var step: Bool? = false
    public var aaChartModel: AAChartModel?
    @IBOutlet var chartView: UIView!
    var aaChartView: AAChartView?
    public var timer: Timer?
    
    public var myBasicValue:Int?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        overview.progress.setProgress(overview.progress.progress + 0.7, animated: true)
        swipeableCardView.dataSource = self
        renderer2 = CardRenderer2()
        worthCards.dataSource = renderer2
        setUpTheAAChartView()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.view.resignFirstResponder()
        self.worthCards.resignFirstResponder()
        self.swipeableCardView.resignFirstResponder()
    }
    
    func setUpTheAAChartView() {
        let chartViewWidth  = self.chartView.frame.size.width
        let chartViewHeight = self.chartView.frame.size.height
        
        aaChartView = AAChartView()
        self.chartView.layer.cornerRadius = 10.0
        self.chartView.layer.masksToBounds = true
        self.chartView.addSubview(aaChartView!)
        self.aaChartView!.layer.cornerRadius = 10.0
        self.aaChartView!.layer.masksToBounds = true
        aaChartView?.frame = CGRect(x: self.chartView.frame.minX,
                                    y: self.chartView.frame.minY,
                                    width: chartViewWidth,
                                    height: chartViewHeight)
        aaChartView?.scrollEnabled = false
        ///AAChartViewd的内容高度(内容高度默认和 AAChartView 等高)
        aaChartView?.contentHeight = chartViewHeight - 20
        view.addSubview(aaChartView!)
        
        aaChartModel = AAChartModel()
            .chartType(chartType!)//图形类型
            .title("CYBERPUNK")//图形标题
            .subtitle("2077/08/08")//图形副标题
            .dataLabelEnabled(false)//是否显示数字
            .markerRadius(5)//折线连接点半径长度,为0时相当于没有折线连接点
            .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
            .stacking(.normal)
        
        if chartType == AAChartType.area
            || chartType == AAChartType.areaSpline {
            let gradientColorDic = [
                "linearGradient": [
                    "x1": 0,
                    "y1": 0,
                    "x2": 0,
                    "y2": 1
                ],
                "stops": [[0,"#00BFFF"],
                          [1,"#00FA9A"]]//颜色字符串设置支持十六进制类型和 rgba 类型
                ] as [String : Any]
            
            aaChartModel?
                .markerRadius(0)
                .series([
                    AASeriesElement()
                        .name("Tokyo")
                        .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                        .color(gradientColorDic)
                        .step(step!)
                        .toDic()!,
                    AASeriesElement()
                        .name("New York")
                        .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                        .step(step!)
                        .toDic()!,
                    ])
            aaChartModel?.symbolStyle(.innerBlank)
        } else {
            let gradientColorDic = [
                "linearGradient": [
                    "x1": 0,
                    "y1": 0,
                    "x2": 0,
                    "y2": 1
                ],
                "stops": [[0,"rgba(138,43,226,1)"],
                          [1,"rgba(30,144,255,1)"]]//颜色字符串设置支持十六进制类型和 rgba 类型
                ] as [String : Any]
            
            aaChartModel?
                .series([
                    AASeriesElement()
                        .name("Tokyo")
                        .data([3.40, 2.90, 2.30, 3.15, 1.75, 2.75])
                        .color(gradientColorDic)
                        .step(step!)
                        .toDic()!,
                    AASeriesElement()
                        .name("Berlin")
                        .data([1.60, 2.10, 2.70, 1.85, 3.25, 2.25])
                        .step(step!)
                        .toDic()!,
                    ])
            if step! != true {
                aaChartModel?.symbolStyle(.borderBlank)
                    .markerRadius(7)
            }
        }
        
        aaChartView?.aa_drawChartWithChartModel(aaChartModel!)
    }
    
    @objc func onlyRefreshTheChartData() {
        let randomNumArrA = NSMutableArray()
        let randomNumArrB = NSMutableArray()
        for  _ in 0..<12 {
            let randomA = arc4random()%20
            randomNumArrA.add(randomA)
            let randomB = arc4random()%15
            randomNumArrB.add(randomB)
        }
        
        let chartSeriesArr = [
            AASeriesElement()
                .name("2017")
                .data(randomNumArrA as! [Any])
                .toDic()!,
            AASeriesElement()
                .name("2018")
                .data(randomNumArrB as! [Any])
                .toDic()!
        ]
        
        aaChartView?.aa_onlyRefreshTheChartDataWithChartModelSeries(chartSeriesArr)
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
        
        let entertainment = SampleSwipeableCellViewModel(title: "Entertainment",
                                                     color: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0),
                                                     image: #imageLiteral(resourceName: "clown"))
        
        let shopping = SampleSwipeableCellViewModel(title: "Shopping",
                                                 color: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "Shoppping"))
        
        let food = SampleSwipeableCellViewModel(title: "Food",
                                                 color: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "hamburger"))
        
        return [entertainment, shopping, food]
    }
}

extension CardRenderer2 {
    
    var viewModels: [SampleSwipeableCellViewModel] {
        
        
        let transport = SampleSwipeableCellViewModel(title: "Transport",
                                                color: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0),
                                                image: #imageLiteral(resourceName: "subway"))
        
        let education = SampleSwipeableCellViewModel(title: "Education",
                                                 color: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "robot"))
        
        let health = SampleSwipeableCellViewModel(title: "Health",
                                                 color: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0),
                                                 image: #imageLiteral(resourceName: "clown"))
        
        return [transport, education, health]
    }
    
}





