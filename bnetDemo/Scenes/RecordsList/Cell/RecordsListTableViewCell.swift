//
//  RecordsListTableViewCell.swift
//  bnetDemo
//
//  Created by Артем Григорян on 08/06/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListCellViewModel {
    var body: String { get }
    var da: Date { get }
    var dm: Date { get }
}

class RecordsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var da: UILabel!
    @IBOutlet weak var dm: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var dmInfoLabel: UILabel!
    @IBOutlet weak var fromBodyToDaInfoLabel: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //сделаем константу равным 8, чтобы не было большого пустого пространства между body и da
        fromBodyToDaInfoLabel.constant = 8
        //так как изначально дата создания совпадает с датой модификации, то дата модификации показана не будет
        dmInfoLabel.isHidden = true
        dm.isHidden = true
    }

    func set(viewModel: RecordsListCellViewModel) {
        body.text = viewModel.body
        da.text = getStringFromDate(date: viewModel.da)
        //если дата создания не совпадает с датой модификации, то
        if viewModel.da != viewModel.dm {
            //установим значение в лейбл с датой модификации
            dm.text = getStringFromDate(date: viewModel.dm)
            //покажем этот лейбл
            dm.isHidden = false
            //покажем лейбл "Дата модификации"
            dmInfoLabel.isHidden = false
            //установим констрейнт от body до da равным 33, так как дата модификации теперь будет показана и body нужно "подвинуться"
            fromBodyToDaInfoLabel.constant = 33
        }
    }
    
    func getStringFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateFormat = "dd.MM.yyyy hh:mm"
        formatter.timeZone = TimeZone(identifier: "GMT")
        
        let stringFromDate = formatter.string(from: date)
        
        return stringFromDate
    }
}
