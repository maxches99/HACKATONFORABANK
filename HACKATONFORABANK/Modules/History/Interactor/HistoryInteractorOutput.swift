//
//  HistoryInteractorOutput.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

protocol HistoryInteractorOutput {
    func sendedItems(dischargeResponse: DischargeResponse)
    func sendedMonthAnalytic(monthAnalyticResponse: MonthAnalytic)
    func sendedPeoples(peoples: [People])
}
