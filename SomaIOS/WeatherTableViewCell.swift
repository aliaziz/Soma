//
//  WeatherTableViewCell.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/13/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherDate: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
