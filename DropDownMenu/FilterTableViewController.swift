//
//  FilterTableViewController.swift
//  DropDownMenu
//
//  Created by Sumit Ghosh on 05/12/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit
protocol ApplyButtonDelegate{
    
  func FinalAction(FinalArray:NSArray,MaxValue:String) -> Void
    
}
class FilterTableViewController: UITableViewController,UpdateMaxPrice{
    var dataArray:Array<Any>!
    var activeSection:Int!
    var width:CGFloat!
    var height:CGFloat!
    var expandedSection:Int!
    var SelectedData:NSMutableArray!
    var maxPrice:String!
    var filterDelegate:ApplyButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SelectedData = NSMutableArray.init()
        
        let data = dataModel.init().dataForMenu()
        print(data)
        dataArray = data as! Array
        
        
        
        let nibPriceCell = UINib(nibName: "PriceTableViewCell", bundle: nil)
        
        tableView.register(nibPriceCell, forCellReuseIdentifier: "SliderCell")
        
        let nibSelectionCell = UINib(nibName: "CommonTableViewCell", bundle: nil)
        
        tableView.register(nibSelectionCell, forCellReuseIdentifier: "Common")
    }
    
    func loadFilter(controller:UIViewController) -> Void {
        addChildViewController(self)
        controller.view.addSubview(self.view)
        self.didMove(toParentViewController: controller)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArray.count+1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(expandedSection != nil){
        if(expandedSection == indexPath.section){
           return 100
        }else{
            return 0
        }
        }else{
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let backGroundView:UIView = UIView.init()
        backGroundView.frame = CGRect(x:0,y:0,width:tableView.frame.size.width,height:50)
        backGroundView.backgroundColor = UIColor(red: 195/255, green: 0/255, blue: 9/255, alpha: 1.0)
    
        let sectionHeader:UILabel = UILabel.init(frame: CGRect(x:10,y:0,width:tableView.frame.size.width-60,height:backGroundView.frame.size.height))
        
        sectionHeader.backgroundColor = UIColor.clear
        sectionHeader.textColor = UIColor.white
        if section == 0 {
            sectionHeader.text = "Price"
        }else{
        let Dict:NSDictionary = dataArray[section-1] as! NSDictionary
        sectionHeader.text = Dict .object(forKey: "message") as? String
        }
        backGroundView.addSubview(sectionHeader)
        
        let expand:UIButton = UIButton.init(frame: CGRect(x:backGroundView.frame.size.width-60,y:backGroundView.frame.size.height/2-15,width:40,height:30))
        expand.tag = section
        
        if(expandedSection != nil)&&(expandedSection == section){
            expand.setImage(UIImage.init(named: "up.png"), for: UIControlState.normal)
        }else{
            expand.setImage(UIImage.init(named: "down.png"), for: UIControlState.normal)
        }
        expand.addTarget(self, action:#selector(expandButtonAction(sender:)) , for: UIControlEvents.touchUpInside)
        backGroundView .addSubview(expand)
        
        return backGroundView
    }
    @objc func expandButtonAction(sender: UIButton){
        if (expandedSection == nil) {
            expandedSection = sender.tag
        }else{
           if((expandedSection) == sender.tag){
               expandedSection = nil
           }else{
             expandedSection=sender.tag
           }
        }
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCell", for: indexPath) as! PriceTableViewCell
            cell.delegate = self
            return cell;
        }else{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Common", for: indexPath) as! CommonTableViewCell
            if(expandedSection != nil)&&(expandedSection == indexPath.section){
            activeSection = indexPath.section - 1
            width = cell.frame.size.width
            height = cell.frame.size.height
            cell.CollectionView.delegate = self as? UICollectionViewDelegate
            cell.CollectionView.dataSource = self as? UICollectionViewDataSource
            }
            return cell;
        }
 
    }
    func  updateMaxPrice(maxValue:String) -> Void {
        maxPrice=maxValue
    }
    
    @IBAction func applyAction(_ sender: Any) {
        filterDelegate?.FinalAction(FinalArray: SelectedData, MaxValue: maxPrice)
        
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
}
extension FilterTableViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      let Dict:NSDictionary = dataArray[activeSection] as! NSDictionary
        let Array:NSArray = Dict.object(forKey: "data")as! NSArray
        
        return Array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Dict:NSDictionary = dataArray[activeSection] as! NSDictionary
        let Array:NSArray = Dict.object(forKey: "data")as! NSArray
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
        
        let TempDict:NSDictionary = Array[indexPath.row] as! NSDictionary
        cell.contentLabel.text = TempDict .object(forKey: "name") as? String
       
        
        if(self .compareDictInArray(Dict: TempDict)){
            cell.checkBox.isHidden = false
        }else{
            cell.checkBox.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let Dict:NSDictionary = dataArray[activeSection] as! NSDictionary
        let Array:NSArray = Dict.object(forKey: "data")as! NSArray
        let Dictionary:NSDictionary = Array[indexPath.row] as! NSDictionary
        let muttableDict:NSMutableDictionary = Dictionary.mutableCopy() as! NSMutableDictionary
        muttableDict .setObject(Dict.object(forKey: "message") as! String, forKey: "category" as NSCopying)
        
        if SelectedData.count != 0 {
            if self.compareDictInArray(Dict: muttableDict) {
                SelectedData.remove(muttableDict)
            }else{
                SelectedData .add(muttableDict)
            }
        }else{
        SelectedData .add(muttableDict)
        }
        collectionView .reloadData()
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width:width/3-3,height:height/2-5)
    }

    func compareDictInArray(Dict:NSDictionary) -> Bool {
        var isPresent:Bool = false
        for data in SelectedData{
            
            let ElementDict = data as! NSDictionary
            if(ElementDict.object(forKey: "name")as! String == Dict.object(forKey: "name")as! String)&&(ElementDict.object(forKey: "id")as! String == Dict.object(forKey: "id")as! String){
                
                isPresent = true
            }
        }
        return isPresent
    }
}
