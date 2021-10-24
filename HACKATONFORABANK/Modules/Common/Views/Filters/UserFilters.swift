//
//  UserFilters.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI

struct UserFilters: View {
    
    @State var filters: [FilterType] = []
    @State var peoples: [People]?
    
    var onTapAction: (([FilterType]) -> Void)? = nil
    
    var body: some View {
        if let peoples = peoples, !peoples.isEmpty {
            VStack {
                Spacer()
                    .frame(height: 20)
                HStack {
                    Text("Отправители/Получатели")
                        .font(.footnote)
                        .fontWeight(.thin)
                        .padding(.leading, 10.0)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Spacer()
                            .frame(width: 10)
                        ForEach(peoples) { people in
                            UserFilter(name: people.name ?? "", isChoosed: filters.contains(.user(people.name ?? ""))) { userFilter in
                                if !filters.contains(userFilter) {
                                    filters.removeAll()
                                    filters.append(userFilter)
                                } else {
                                    filters.removeAll()
                                }
                                onTapAction!(filters)
                            }
                        }
                        Spacer()
                            .frame(width: 10)
                        
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}

struct UserFilters_Previews: PreviewProvider {
    static var previews: some View {
        UserFilters()
    }
}
