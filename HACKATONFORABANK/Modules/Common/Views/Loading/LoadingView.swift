//
//  LoadingView.swift
//  InRoad
//
//  Created by Максим Чесников on 25.08.2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("Green"))
                .ignoresSafeArea()
            Text("In Road")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "tram")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Image(systemName: "airplane")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Image(systemName: "car")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
