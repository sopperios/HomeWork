//
//  NoteCell.swift
//  NoteAPP
//
//  Created by user46 on 2018/5/24.
//  Copyright © 2018年 Mint. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var st: UISwitch!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
