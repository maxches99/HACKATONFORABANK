//
//  UserFilter.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI

struct UserFilter: View {
    
    var name = ""
    
    @State var isChoosed: Bool = false
    
    var onTapAction: ((FilterType) -> Void)? = nil
    
    var body: some View {
        Button(action: {
            isChoosed.toggle()
            onTapAction!(.user(name))
//            onTapAction!()
        }) {
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(isChoosed ? .red : Color(UIColor.label))
                    Text(
                        "\(name.split(separator: " ").first?.first?.description ?? "")\(name.split(separator: " ").last?.first?.description ?? "")"
                    )
                        .font(.largeTitle)
                        .foregroundColor(Color(uiColor: UIColor.systemBackground))
                }
                .frame(width: 80, height: 80)
                Text(
                    "\(name.split(separator: " ").first?.description ?? "") \(name.split(separator: " ").last?.first?.description ?? "")"
                )
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(uiColor: UIColor.label))
            }
        }
    }
}

struct UserFilter_Previews: PreviewProvider {
    static var previews: some View {
        UserFilter(name: Discharge.data.fastPaymentData?.foreignName ?? "")
    }
}
