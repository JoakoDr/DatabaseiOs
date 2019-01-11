//
//  GroupTableViewCell.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 11/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameGroupLabel: UILabel?
    @IBOutlet weak var personGroupLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
