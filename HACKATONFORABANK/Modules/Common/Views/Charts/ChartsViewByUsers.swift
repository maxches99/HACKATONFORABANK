//
//  ChartsViewByUsers.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import SwiftUI
import Neumorphic

struct ChartsViewByUsers: View {
    
    @State var peopleAnalytic: [People]?
    
    @State var isHiddenRings = true
    @State var data = ChartData([10,30,50,1923,294,54])
    
    @State var dataRing: ChartData
    
    @State var colors: [People: Color] = [:]
    
    @State var pieChartStyle: ChartStyle
    @State var ringChartStyle: ChartStyle
    
    init(peopleAnalytic: [People]?) {
        
        self.peopleAnalytic = peopleAnalytic
        
        var arrayOfTransfers: [Double] = []
        var arrayOfColors: [ColorGradient] = []
        var colors: [People: Color] = [:]
        
        for people in peopleAnalytic ?? [] {
            let color = Color.random
            arrayOfTransfers.append(people.percent ?? 0)
           
            arrayOfColors.append(ColorGradient(color))
            colors[people] = color
        }
        
        data = ChartData(arrayOfTransfers)
        dataRing = ChartData(arrayOfTransfers)
        
        pieChartStyle = ChartStyle(backgroundColor: .white, foregroundColor: arrayOfColors)
        ringChartStyle = ChartStyle(backgroundColor: .white, foregroundColor: arrayOfColors)
        self.colors = colors
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Text("Аналитика по обороту среди пользователей")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .padding(.leading, 20)
                Spacer()
            }
            Spacer()
                .frame(height: 20)
            HStack {
                Spacer()
                    .frame(width: 20)
                if !isHiddenRings {
                    VStack {
                        HStack {
                            RingsChart(widthOfLine: 5)
                                .environmentObject(data)
                                .environmentObject(ringChartStyle)
                                .disabled(true)
                            .frame(width: 130, height: 130)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 20)
                        VStack(alignment: .leading) {
                            ForEach(peopleAnalytic ?? []) { people in
                                HStack {
                                    Circle()
                                        .foregroundColor(getColor(people))
                                        .frame(width: 10, height: 10)
                                    Spacer()
                                        .frame(width: 10, height: 10)
                                    Text("\(people.name ?? "") - \(people.count?.rounded(toPlaces: 2).toString(forCurrencyCode: "RUR") ?? "")")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .fixedSize(horizontal: true, vertical: true)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                } else {
                    VStack {
                        HStack {
                            PieChart()
                                .environmentObject(data)
                                .environmentObject(pieChartStyle)
                                .disabled(true)
                            .frame(width: 130, height: 130)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 20)
                        VStack(alignment: .leading) {
                            ForEach(peopleAnalytic ?? []) { people in
                                HStack(spacing: 0) {
                                    Circle()
                                        .foregroundColor(getColor(people))
                                        .frame(width: 10, height: 10)
                                    Spacer()
                                        .frame(width: 10)
                                        .frame(maxWidth: 10)
                                    Text("\(people.name ?? "") - \(people.percent?.rounded(toPlaces: 2).clean ?? "")%")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .fixedSize(horizontal: true, vertical: true)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
                
                Spacer()
                    .frame(width: 20)
            }
            Spacer()
                .frame(minHeight: 20)
        }
        .onTapGesture {
            isHiddenRings.toggle()
        }
        .background(
            RoundedRectangle(cornerRadius: 30).fill(Color(UIColor.systemBackground))
                .softInnerShadow(RoundedRectangle(cornerRadius: 30), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, spread: 0.05, radius: 2)
                        )
    }
    
    func getColor(_ people: People) -> Color {
        return pieChartStyle.foregroundColor[(peopleAnalytic?.firstIndex(of: people))!].endColor
    }
}
