//
//  TimeFilters.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI

struct TimeFilters: View {
    
    @State var filters: [FilterType] = []
    
    var onTapAction: (([FilterType]) -> Void)? = nil
    
    @State var startDate = Date()
    @State var endDate = Date()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Text("Сортировка по времени")
                    .font(.footnote)
                    .fontWeight(.thin)
                    .padding(.leading, 10.0)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(FilterType.timeFilters) { filter in
                        Spacer()
                            .frame(width: 10)
                        switch filter {
                        case .period(let startDate, let endDate):
                            DatePicker(selection: self.$startDate, displayedComponents: [.date], label: { Text("С") })
                                .foregroundColor(filters.contains(.period(self.startDate, self.endDate)) ? .red : .gray)
                                .accentColor(filters.contains(.period(self.startDate, self.endDate)) ? .red : .gray)
                                .colorInvert()
                                .colorMultiply(filters.contains(.period(self.startDate, self.endDate)) ? .red : .gray)
                                        
                                
                            
                            DatePicker(selection: self.$endDate, displayedComponents: [.date], label: { Text("По") })
                                .foregroundColor(filters.contains(.period(self.startDate, self.endDate)) ? .red : .gray)
                                .accentColor(filters.contains(.period(self.startDate, self.endDate)) ? .red : .gray)
                                .colorInvert()
                                .colorMultiply(filters.contains(.period(self.startDate, self.endDate)) ? .red : .gray)
                                
                        default:
                            Filter(filter: filter, isChoosed: filters.contains(filter)) { filterType in
                                if !filters.contains(filterType) {
                                    filters.removeAll()
                                    filters.append(filterType)
                                } else {
                                    filters.removeAll()
                                }
                                onTapAction!(filters)
                            }
                        }
                    }
                    Spacer()
                        .frame(width: 10)
                }
            }
            .onChange(of: self.startDate, perform: { value in
                
                filters.removeAll()
                filters.append(.period(value, endDate))
                onTapAction!([.period(value, endDate)])
            })
            .onChange(of: self.endDate, perform: { value in
                 
                filters.removeAll()
                filters.append(.period(startDate, value))
                onTapAction!([.period(startDate, value)])
            })
        }
    }
}

struct TimeFilters_Previews: PreviewProvider {
    static var previews: some View {
        TimeFilters()
    }
}
