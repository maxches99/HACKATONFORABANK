//
//  AllSummView.swift
//  Hackaton
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI
import Neumorphic

struct AllSummView: View {
    
    @State var isShowLoss = false
    
    @State var summOut: Double = 0
    @State var summIn: Double = 0
    @State var text: String = "Потрачено в этом месяце"
    
    var onTapAction: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(minHeight: 40)
                Text("\(isShowLoss ? summOut.clean : summIn.clean) Р")
                    .font(.title2)
                    .fontWeight(.heavy)
                Spacer()
                    .frame(height: 20)
                Text(isShowLoss ? "Потрачено в этом месяце" : "Получено в этом месяце")
                    .font(.footnote)
                    .fontWeight(.thin)
                Spacer()
                    .frame(minHeight: 40)
            }
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 30).fill(Color(UIColor.systemBackground))
                .softInnerShadow(RoundedRectangle(cornerRadius: 30), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, spread: 0.05, radius: 2)
                        )
        .onTapGesture(perform: {
            isShowLoss.toggle()
        })
    }
}

struct AllSummView_Previews: PreviewProvider {
    static var previews: some View {
        AllSummView(summOut: 300000)
    }
}
