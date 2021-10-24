//
//  DirectionFilters.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI

struct DirectionFilters: View {
    
    @State var filters: [FilterType] = []
    
    var onTapAction: (([FilterType]) -> Void)? = nil
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Text("Направление платежей")
                    .font(.footnote)
                    .fontWeight(.thin)
                    .padding(.leading, 10.0)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(FilterType.directionFilters) { filter in
                        Spacer()
                            .frame(width: 10)
                        Filter(filter: filter, isChoosed: filters.contains(filter)) { filterType in
                            if filters.contains(filter) {
                                filters.removeAll()
                            } else {
                                filters.removeAll()
                                filters.append(filterType)
                            }
                            onTapAction!(filters)
                        }
                    }
                    Spacer()
                        .frame(width: 10)
                }
            }
        }
    }
}

struct DirectionFilters_Previews: PreviewProvider {
    static var previews: some View {
        DirectionFilters()
    }
}
