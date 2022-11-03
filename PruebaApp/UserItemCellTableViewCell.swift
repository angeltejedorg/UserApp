//
//  UserItemCellTableViewCell.swift
//  PruebaApp
//
//  Created by angel.tejedore on 2/11/22.
//

import UIKit

class UserItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var emailLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(name: String?, phone: String?, email: String?) {
        guard let name = name,
              let phone = phone,
              let email = email else { return }
        
        nameLabel.text = name
        phoneNumberLabel.text = phone
        emailLabel.text = email
    }
}


