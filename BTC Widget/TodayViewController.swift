//
//  TodayViewController.swift
//  BTC Widget
//
//  Created by numanuma08 on 2014/10/17.
//  Copyright (c) 2014年 Ray Wenderlich. All rights reserved.
//

import UIKit
import NotificationCenter
import CryptoCurrencyKit

class TodayViewController: CurrencyDataViewController, NCWidgetProviding {

    @IBOutlet weak var toggleLineChartButton: UIButton!
    @IBOutlet weak var lineChartHeightConstraint: NSLayoutConstraint!
    
    var lineChartIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartHeightConstraint.constant = 0
        
        lineChartView.dataSource = self
        lineChartView.delegate = self
        
        priceLabel.text = "--"
        priceChangeLabel.text = "--"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchPrices{ error in
            if error == nil {
                self.updatePriceLabel()
                self.updatePriceChangeLabel()
                self.updatePriceHistoryLineChart()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updatePriceHistoryLineChart()
    }
    
    override func lineChartView(lineChartView: JBLineChartView!,
        colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
            return UIColor(red: 0.17, green: 0.49,
                blue: 0.82, alpha: 1.0)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        fetchPrices{ error in
            if error == nil {
                self.updatePriceLabel()
                self.updatePriceChangeLabel()
                self.updatePriceHistoryLineChart()
                completionHandler(.NewData)
            } else {
                completionHandler(.NoData)
            }
        }
    }
    
    @IBAction func toggleLineChart(sender: UIButton) {
        if lineChartIsVisible {
            lineChartHeightConstraint.constant = 0
            let transform = CGAffineTransformMakeRotation(CGFloat(0))
            toggleLineChartButton.transform = transform
            lineChartIsVisible = false
        } else {
            lineChartHeightConstraint.constant = 98
            let transform = CGAffineTransformMakeRotation(CGFloat(180.0 * M_PI / 180.0))
            toggleLineChartButton.transform = transform
            lineChartIsVisible = true
        }
    }
}
