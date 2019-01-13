//
//  UserTableViewCell.swift
//  DatabaseSwift
//
//  Created by Dario Autric on 13/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var foodLabel: UILabel?
    @IBOutlet weak var imgPaid: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
