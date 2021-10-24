//
//  SummFilter.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI

struct SummFilter: View {
    
    @State var filters: [FilterType] = []
    
    @State var value: Double = 0 {
        didSet {
            filters.map { filter in
                switch filter {
                case .summ:
                    filters.removeAll(where: {$0 == filter})
                default:
                    break
                }
            }
            
            filters.append(FilterType.summ(value))
            onTapAction!(filters)
        }
    }
    
    var onTapAction: (([FilterType]) -> Void)? = nil
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Text("Сортировка по сумме")
                    .font(.footnote)
                    .fontWeight(.thin)
                    .padding(.leading, 10.0)
                Spacer()
            }
            HStack {
                Spacer()
                    .frame(width: 10)
            VStack {
                
                Slider(value: $value, in: ClosedRange(uncheckedBounds: (0, 1000000)), onEditingChanged: {_ in
                    filters.append(FilterType.summ(value))
                })
                    .foregroundColor(.red)
                    .accentColor(.red)
                    .padding(.horizontal, 30)
                Text("\(value.rounded(toPlaces: 0).toString(forCurrencyCode: "RUR"))")
                    .font(.title3)
                    .fontWeight(.bold)
                HStack {
                    ForEach(FilterType.summFilters) { filter in
                        switch filter {
                        case .summUp:
                            Filter(filter: .summUp, isChoosed: filters.contains(.summUp)) { summFilter in
                                if filters.contains(summFilter) {
                                    filters.removeAll(where: {$0 == FilterType.summUp})
                                    filters.map { filter in
                                        switch filter {
                                        case .summ:
                                            filters.removeAll(where: {$0 == filter})
                                        default:
                                            break
                                        }
                                    }
                                } else {
                                    filters.removeAll()
                                    filters.append(FilterType.summ(value))
                                    filters.append(summFilter)
                                    
                                }
                                onTapAction!(filters)
                            }
                            Spacer()
                                .frame(width: 10)
                        case .summDown:
                            Filter(filter: .summDown, isChoosed: filters.contains(.summDown)) { summFilter in
                                if filters.contains(summFilter) {
                                    filters.removeAll()
                                } else {
                                    filters.removeAll()
                                    filters.append(FilterType.summ(value))
                                    filters.append(summFilter)
                                    
                                }
                                onTapAction!(filters)
                            }
                        default:
                            EmptyView()
                        }
                    }
                    
                }
            }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}

struct SummFilter_Previews: PreviewProvider {
    static var previews: some View {
        SummFilter()
    }
}
