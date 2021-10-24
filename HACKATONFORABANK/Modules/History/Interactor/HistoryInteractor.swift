//
//  HistoryInteractor.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import Foundation

class HistoryInteractor: HistoryInteractorInput {
    
    var presenter: HistoryInteractorOutput!
    
    lazy var service = DischargeService()
    lazy var monthService = MonthAnalyticsService()
    lazy var lastService = LastService()
    
    func getItemsPerPage(page: Int, filters: [FilterType]) {
        service.loadDischarges(page: page, filters: filters) { [weak self] discharges, error in
            guard let strongSelf = self else { return }
            if let discharges = discharges {
                strongSelf.presenter.sendedItems(dischargeResponse: discharges)
            }
        }
    }
    
    func getMonthAnalytics() {
        monthService.loadAnalytics(date: Date()) { [weak self] monthAnalytic, error in
            guard let strongSelf = self else { return }
            if let monthAnalytic = monthAnalytic {
                strongSelf.presenter.sendedMonthAnalytic(monthAnalyticResponse: monthAnalytic)
            }
        }
    }
    
    func getPeoples() {
        lastService.loadLasts { [weak self] peoples, error in
            guard let strongSelf = self else { return }
            if let peoples = peoples {
                strongSelf.presenter.sendedPeoples(peoples: peoples)
            }
        }
    }
    
    
    
}
