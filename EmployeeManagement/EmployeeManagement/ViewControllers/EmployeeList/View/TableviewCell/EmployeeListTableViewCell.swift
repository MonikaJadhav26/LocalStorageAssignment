//
//  EmployeeListTableViewCell.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import UIKit

class EmployeeListTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeDesignationLabel: UILabel!
    @IBOutlet weak var employeeCompetancyLabel: UILabel!
    @IBOutlet weak var employeeCurrentProjectLabel: UILabel!
    @IBOutlet weak var employeeIdLabel: UILabel!
    @IBOutlet weak var employeeProfileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        employeeProfileImage.layer.cornerRadius = employeeProfileImage.frame.size.width / 2
        backgroundContainerView.layer.cornerRadius = 5
        backgroundContainerView.layer.shadowColor = UIColor.black.cgColor
        backgroundContainerView.layer.shadowOpacity = 1
        backgroundContainerView.layer.shadowOffset = .zero
        backgroundContainerView.layer.shadowRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
