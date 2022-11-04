//
//  UserItemCellTableViewCell.swift
//  PruebaApp
//
//  Created by angel.tejedore on 2/11/22.
//

import UIKit


class UserItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var publicationsButton: UIButton!
    
    var user: User?
    weak var userInfoDelegate: UserInfoDelegate?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var emailLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func buttonClicked(_ sender: UIButton) {
        userInfoDelegate?.buildView(with: user)
    }
    func setupCell(user: User?) {
        self.user = user
        nameLabel.text = user?.name
        phoneNumberLabel.text = user?.phone
        emailLabel.text = user?.email
    }
}

protocol UserInfoDelegate: AnyObject {
    func buildView(with user: User?)
}

