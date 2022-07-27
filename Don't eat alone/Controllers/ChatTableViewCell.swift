//
//  ChatTableViewCell.swift
//  Don't eat alone
//
//  Created by Ilyess NAIT BELKACEM on 25/07/2022.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var messageContentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
