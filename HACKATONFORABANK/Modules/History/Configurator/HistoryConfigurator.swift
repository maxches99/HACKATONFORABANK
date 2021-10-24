//
//  HistoryConfigurator.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import Foundation

class HistoryConfigurator {
    
    static func configure() -> HistoryView {
        var presenter = HistoryPresenter()
        var interactor = HistoryInteractor()
        var view = HistoryView(output: presenter)
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
}
