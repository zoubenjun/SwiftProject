//
//  CollectionPrettyCell.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import UIKit

class CollectionPrettyCell: BaseCollectionViewCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
