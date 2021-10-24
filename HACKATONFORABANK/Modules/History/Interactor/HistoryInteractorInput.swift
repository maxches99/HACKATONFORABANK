//
//  HistoryInteractorInput.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

protocol HistoryInteractorInput {
    func getItemsPerPage(page: Int, filters: [FilterType])
    func getMonthAnalytics()
    func getPeoples()
}
