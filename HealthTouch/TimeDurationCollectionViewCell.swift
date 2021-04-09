//
//  TimeDurationCollectionViewCell.swift
//  HealthTouch
//
//  Created by Naman Jain on 06/04/21.
//

import UIKit

class TimeDurationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    static func nib() ->UINib{
        return UINib(nibName: "TimeDurationCollectionViewCell", bundle: nil)
    }
    
    func configure(duration: String){
        timeDuration.text = duration
    }

}
