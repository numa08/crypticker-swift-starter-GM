//
//  TodayViewController.swift
//  BTC Widget
//
//  Created by Thomas Durand on 28/05/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import CryptoCurrencyKit
import NotificationCenter

class TodayViewController: CurrencyDataViewController, NCWidgetProviding {
        
    @IBOutlet weak var toggleLineChartButton: UIButton!
    @IBOutlet weak var lineChartHeightConstraint: NSLayoutConstraint!
    
    var lineChartIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        lineChartHeightConstraint.constant = 0
        
        lineChartView.delegate = self
        lineChartView.dataSource = self
        
        priceLabel.text = "--"
        priceChangeLabel.text = "--"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPrices { error in
            if error == nil {
                self.updatePriceLabel()
                self.updatePriceChangeLabel()
                self.updatePriceHistoryLineChart()
            }
        }
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
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
    
    @IBAction func toggleLineChart(sender: UIButton) {
        if lineChartIsVisible {
            lineChartHeightConstraint.constant = 0
            let transform = CGAffineTransformMakeRotation(0)
            toggleLineChartButton.transform = transform
            lineChartIsVisible = false
        } else {
            lineChartHeightConstraint.constant = 98
            let transform = CGAffineTransformMakeRotation(CGFloat(180.0 * M_PI/180.0))
            toggleLineChartButton.transform = transform
            lineChartIsVisible = true
        }
    }
}
