//
//  MosqueTableViewCell.swift
//  MadarTask
//
//  Created by Admin on 3/13/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class MosqueTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mosqueNameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
