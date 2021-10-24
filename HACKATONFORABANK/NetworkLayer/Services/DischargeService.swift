//
//  DischargeService.swift
//  Hackaton
//
//  Created by Максим Чесников on 22.10.2021.
//

import Foundation
import Combine

/// Service to network work of discharges models
class DischargeService {
    
    public init() {}
    
    fileprivate var networkService = NetworkService()
    
    fileprivate var dischargeResponse: DischargeResponse?
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    /// Method to get DischargeResponse by page
    /// - Parameters:
    ///   - page: Current page to pagination
    ///   - completion: It return's single DischargeResponse or APIError
    func loadDischarges(page: Int, filters: [FilterType], completion: @escaping (DischargeResponse?, APIError?) -> Void ) {
        let cancellable = networkService
            .request(from: DischargeAPI.getDischargesPerPage(page, filters))
            .sink { [weak self] res in
                guard let strongSelf = self else { return }
                switch res {
                case .finished:
                    completion(strongSelf.dischargeResponse, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            } receiveValue: { [weak self] response in
                self?.dischargeResponse = response
            }
        
        cancellables.insert(cancellable)
    }
    
}

class MonthAnalyticsService {
    
    public init() {}
    
    fileprivate var networkService = NetworkService()
    
    fileprivate var monthAnalyticResponse: MonthAnalytic?
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    /// Method to get DischargeResponse by page
    /// - Parameters:
    ///   - page: Current page to pagination
    ///   - completion: It return's single DischargeResponse or APIError
    func loadAnalytics(date: Date, completion: @escaping (MonthAnalytic?, APIError?) -> Void ) {
        let cancellable = networkService
            .request(from: MonthAPI.getMonthInfo(date))
            .sink { [weak self] res in
                guard let strongSelf = self else { return }
                switch res {
                case .finished:
                    completion(strongSelf.monthAnalyticResponse, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            } receiveValue: { [weak self] response in
                self?.monthAnalyticResponse = response
            }
        
        cancellables.insert(cancellable)
    }
    
}

class LastService {
    
    public init() {}
    
    fileprivate var networkService = NetworkService()
    
    fileprivate var peopleResponse: [People]?
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    /// Method to get DischargeResponse by page
    /// - Parameters:
    ///   - page: Current page to pagination
    ///   - completion: It return's single DischargeResponse or APIError
    func loadLasts(completion: @escaping ([People]?, APIError?) -> Void ) {
        let cancellable = networkService
            .request(from: LastAPI.getLasts)
            .sink { [weak self] res in
                guard let strongSelf = self else { return }
                switch res {
                case .finished:
                    completion(strongSelf.peopleResponse, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            } receiveValue: { [weak self] response in
                self?.peopleResponse = response
            }
        
        cancellables.insert(cancellable)
    }
    
}

