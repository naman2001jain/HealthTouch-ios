//
//  ViewController.swift
//  HealthTouch
//
//  Created by Naman Jain on 06/04/21.
//

import UIKit
import Charts
import TinyConstraints

class ViewController: UIViewController {
    
    
    let durationArray = ["Today","Previous Day","Last Day","Last week","Last Month"]
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = UIColor(named: "graphBackgroundColor")
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.setLabelCount(6, force: false)
        xAxis.labelTextColor = .white
        xAxis.axisLineColor = .white
        xAxis.labelPosition = .bottomInside
        
        chartView.xAxis.labelPosition = .bottom
        chartView.animate(xAxisDuration: 2.5)
        chartView.legend.enabled = false
        return chartView
    }()
    let graphData = GraphData()
    //outlets
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var redInnerView: UIView!
    @IBOutlet weak var whiteInnerView: UIView!
    @IBOutlet weak var durationCollectionView: UICollectionView!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var contactUsBtn: UIButton!
    @IBOutlet weak var phoneSymbolBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //rounding the corners
        whiteInnerView.layer.cornerRadius = self.view.frame.height/20.0
        whiteInnerView.layer.maskedCorners = [.layerMinXMaxYCorner]
        redInnerView.layer.cornerRadius = self.view.frame.height/20.0
        redInnerView.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        contactUsBtn.layer.cornerRadius = 10
        phoneSymbolBtn.layer.cornerRadius = 10
        
        //delegates
        durationCollectionView.delegate = self
        
        //data source
        durationCollectionView.dataSource = self
        
        //nib registeration
        durationCollectionView.register(TimeDurationCollectionViewCell.nib(), forCellWithReuseIdentifier: "TimeDurationCollectionViewCell")
        
        //setting the graph view
        graphView.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: graphView)
        lineChartView.height(to: graphView)
        
        setData()
        
    }
    func setData(){
        let set1 = LineChartDataSet(entries: GraphData().yValues, label: "health")
        
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 3
        set1.setColor(.blue)
        set1.fill = Fill(color: .blue)
        set1.fillAlpha = 0.6
        set1.drawFilledEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .red
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        
        lineChartView.data = data
    }

}
//MARK:- collectionViewDelegate
extension ViewController: UICollectionViewDelegate{
    
}


//MARK:- collectionViewDataSource
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return durationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeDurationCollectionViewCell", for: indexPath) as! TimeDurationCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.configure(duration: durationArray[indexPath.row])
        return cell
    }
    
    
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/4.0 , height: collectionView.bounds.height - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
    }
}

