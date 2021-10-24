//
//  HistoryPresenter.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import Foundation
import Combine

class HistoryPresenter: ObservableObject {
    
    var interactor: HistoryInteractorInput!
    
    @Published var items: [Discharge] = [] {
        didSet {
            if !items.isEmpty {
                updateGrouppedList()
            } else {
                sections.removeAll()
                grouppedList.removeAll()
            }
        }
    }
    @Published var filters: [FilterType] = [] {
        didSet {
            page = 1
            state = false
            items.removeAll()
            grouppedList.removeAll()
            sections.removeAll()
            interactor.getItemsPerPage(page: page, filters: filters)
        }
    }
    @Published var currentDischarge: Discharge?
    @Published var spinnerState: Bool = false
    
    @Published var state: Bool = false
    @Published var stateOfAnalytic: Bool = false
    @Published var stateOfPeoples: Bool = false
    
    @Published var isEnabledPagination: Bool = false
    @Published var peoples: [People]? = []
    
    var grouppedList: [String: [Discharge]] = [:]
    var dates: [String] {
        grouppedList.map{$0.key}
    }
    var discharges: [[Discharge]] {
        grouppedList.map {$0.value}
    }
    
    var sections: [String] = []
    
    var page = 1
    
    var monthAnalytics: MonthAnalytic?
    
    init() {
    }
    
    func loadDataPerPage() {
        spinnerState = true
        interactor.getItemsPerPage(page: page, filters: filters)
    }
    
    @objc func refresh(_ sender: AnyObject?) {
        page = 1
        state = false
        sections.removeAll()
        grouppedList.removeAll()
        interactor.getItemsPerPage(page: page, filters: filters)
        interactor.getMonthAnalytics()
    }
    
    
    
    func updateSections() {
        var sections: [Date] = []
        items.map { item in
            if sections.firstIndex(of: item.getTranDate) == nil {
                sections.append(item.getTranDate)
            }
        }
        sections = sections.sorted().reversed()
        sections.forEach { section in
            
            var string = ""
            let components = section.get(.day, .month, .year)
            if let day = components.day, let month = components.month, let year = components.year {
                string = "\(day)/\(month)/\(year)"
                if !self.sections.contains(string) {
                    self.sections.append(string)
                }
            }
            if grouppedList[string] == nil {
                grouppedList[string] = []
            }
        }
    }
    
    func updateGrouppedList() {
        updateSections()
        items.forEach { item in
            if grouppedList[item.getTranDateString] == nil {
                grouppedList[item.getTranDateString] = [item]
            } else {
                if !(grouppedList[item.getTranDateString]?.contains(item) ?? true) {
                    grouppedList[item.getTranDateString]?.append(item)
                }
            }
        }
        state = true
        spinnerState = false
    }
    
}

extension HistoryPresenter: HistoryInteractorOutput {
    func sendedItems(dischargeResponse: DischargeResponse) {
        isEnabledPagination = dischargeResponse.ableToPagination ?? false
        page = (dischargeResponse.currentPage ?? 0) + 1
        items.append(contentsOf: dischargeResponse.operations)
    }
    
    func sendedMonthAnalytic(monthAnalyticResponse: MonthAnalytic) {
        monthAnalytics = monthAnalyticResponse
        stateOfAnalytic = true
    }
    
    func sendedPeoples(peoples: [People]) {
        self.peoples = peoples
        stateOfPeoples = true
    }
}
