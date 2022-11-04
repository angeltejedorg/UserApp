//
//  PostsCell.swift
//  PruebaApp
//
//  Created by angel.tejedore on 3/11/22.
//

import UIKit

class PostsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(title: String?, body: String?) {
        titleLabel.text = title?.capitalized
        bodyLabel.text = title?.capitalized
    }
    
}
