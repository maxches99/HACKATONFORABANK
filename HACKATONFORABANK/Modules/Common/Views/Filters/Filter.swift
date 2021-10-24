//
//  Filter.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI

struct Filter: View {
    
    var filter: FilterType
    
    @State var isChoosed: Bool = false
    
    var onTapAction: ((FilterType) -> Void)? = nil
    
    var body: some View {
        Button(action: {
            isChoosed.toggle()
            onTapAction!(filter)
            
        }) {
            VStack {
                Spacer()
                    .frame(height: 7)
                HStack {
                    Spacer()
                        .frame(width: 15)
                    Text(filter.name)
                        .font(.callout)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    Spacer()
                        .frame(width: 15)
                }
                Spacer()
                    .frame(height: 7)
            }
        }
        .frame(minHeight: 28)
        .background(Rectangle().foregroundColor(!isChoosed ? .gray : Color(UIColor(named: "CustomRed")!)))
        .cornerRadius(8)
    }
}

struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter(filter: .input) {_ in }
        Filter(filter: .input, isChoosed: true) {_ in }
    }
}
