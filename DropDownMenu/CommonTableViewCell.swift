//
//  CommonTableViewCell.swift
//  DropDownMenu
//
//  Created by Sumit Ghosh on 05/12/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {

    @IBOutlet var CollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        CollectionView?.register(nib, forCellWithReuseIdentifier: "collectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

