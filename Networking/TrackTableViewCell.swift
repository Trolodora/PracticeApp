//
//  TrackTableViewCell.swift
//  Networking
//
//  Created by RomaDUlbich on 8/8/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameOutl: UILabel!
    
    @IBOutlet weak var artistOutl: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
