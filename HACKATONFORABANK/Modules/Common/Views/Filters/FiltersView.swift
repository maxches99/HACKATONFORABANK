//
//  FiltersView.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI

struct FiltersView: View {
    
    @State var filters: [FilterType] = []
    @Binding var peoples: [People]?
    
    var onTapAction: (([FilterType]) -> Void)? = nil
    
    var body: some View {
        VStack {
            UserFilters(peoples: peoples) { userFilters in
                filters.forEach { filter in
                    switch filter {
                    case .user:
                        filters.removeAll(where: { $0 == filter })
                    default:
                        break
                    }
                }
                filters.append(contentsOf: userFilters)
                onTapAction!(filters)
            }
            DirectionFilters() { directionFilter in
                filters.removeAll(where: {$0 == .input})
                filters.removeAll(where: {$0 == .output})
                filters.append(contentsOf: directionFilter)
                onTapAction!(filters)
            }
            TimeFilters() { timeFilter in
                filters.removeAll(where: {$0 == .year})
                filters.map { filter in
                    switch filter {
                    case .period:
                        filters.removeAll(where: {$0 == filter})
                    default:
                        break
                    }
                }
                filters.removeAll(where: {$0 == .month})
                filters.removeAll(where: {$0 == .week})
                filters.removeAll(where: {$0 == .day})
                filters.append(contentsOf: timeFilter)
                onTapAction!(filters)
            }
            SummFilter() { summFilter in
                filters.removeAll(where: {$0 == .summDown})
                filters.removeAll(where: {$0 == .summUp})
                filters.map { filter in
                    switch filter {
                    case .summ:
                        filters.removeAll(where: {$0 == filter})
                    default:
                        break
                    }
                }
                filters.append(contentsOf: summFilter)
                onTapAction!(filters)
            }
                
            Spacer()
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    
    static var previews: some View {
        VStack {
            Spacer()
        }
        .bottomSheet(bottomSheetPosition: .constant(BottomSheetPosition.middle), options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss], headerContent: {
                            //The name of the book as the heading and the author as the subtitle with a divider.
                            HStack(alignment: .bottom) {
                                Text("Фильтры и группировка")
                                    .font(.title).bold()
                            }
            }) {
                FiltersView(peoples: .constant([]))
            }
    }
}

