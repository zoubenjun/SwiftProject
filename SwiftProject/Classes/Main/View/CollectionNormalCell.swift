//
//  CollectionNormalCell.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import UIKit

class CollectionNormalCell: BaseCollectionViewCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
