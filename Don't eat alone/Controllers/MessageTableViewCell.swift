//
//  MessageTableViewCell.swift
//  Don't eat alone
//
//  Created by Ilyess NAIT BELKACEM on 26/07/2022.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
