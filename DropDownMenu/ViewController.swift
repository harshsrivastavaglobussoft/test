//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Sumit Ghosh on 05/12/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ApplyButtonDelegate  {

    @IBOutlet var filterButton: UIButton!
    @IBOutlet var materialLabel: UILabel!
    @IBOutlet var collectionLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    var FilterArray:NSArray!
    var PriceString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        materialLabel.text = ""
        collectionLabel.text = ""
        colorLabel.text = ""
        
    }

    
    @IBAction func filterButtonAction(_ sender: Any) {
        let FilterTable:FilterTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "FilterTableViewController") as! FilterTableViewController
        
        FilterTable.view.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height/2)
        
        FilterTable.filterDelegate = self
        
        addChildViewController(FilterTable)
        self.view.addSubview(FilterTable.view)
        FilterTable.didMove(toParentViewController: self)
    }
    func FinalAction(FinalArray:NSArray,MaxValue:String) -> Void {
        FilterArray = FinalArray.mutableCopy() as! NSArray
        PriceString = MaxValue
        
        print("Filter array",FilterArray)
        print("Max Price",PriceString)
        
        self.priceLabel.text = PriceString
        
        for data in FilterArray{
            let Dict:NSDictionary = data as! NSDictionary
            if Dict.object(forKey: "category")as! String == "Color"{
                let String:String = Dict.object(forKey: "name")as! String
                colorLabel.text = colorLabel.text! + "," + String
            }else if Dict.object(forKey: "category")as! String == "Ocassion"{
                let String:String = Dict.object(forKey: "name")as! String
                collectionLabel.text = collectionLabel.text! + "," + String
            }else if Dict.object(forKey: "category")as! String == "Jewellery materials"{
                let String:String = Dict.object(forKey: "name")as! String
                materialLabel.text = materialLabel.text! + "," + String

            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

