//
//  ChartsView.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI
import Neumorphic

struct ChartsView: View {
    
    @State var monthAnalytic: MonthAnalytic?
    
    @State var isHiddenRings = true
    @State var data = ChartData([10,30,50,1923,294,54])
    
    @State var dataRing: ChartData
    
    @State var pieChartStyle: ChartStyle
    @State var ringChartStyle: ChartStyle
    
    init(monthAnalytic: MonthAnalytic?) {
        
        self.monthAnalytic = monthAnalytic
        
        var arrayOfTransfers: [Double] = []
        var arrayOfColors: [ColorGradient] = []
        
        monthAnalytic?.wasts?.forEach { wast in
            arrayOfTransfers.append(wast.percent ?? 0)
            arrayOfColors.append(ColorGradient(wast.type?.color ?? .brown))
        }
        
        self.data = ChartData(arrayOfTransfers)
        dataRing = ChartData(arrayOfTransfers)
        
        pieChartStyle = ChartStyle(backgroundColor: .white, foregroundColor: arrayOfColors)
        ringChartStyle = ChartStyle(backgroundColor: .white, foregroundColor: arrayOfColors)
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Text("Аналитика за месяц")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .padding(.leading, 20)
                Spacer()
            }
            Spacer()
                .frame(height: 20)
                .frame(maxWidth: 20)
            HStack {
                Spacer()
                    .frame(width: 20)
                if !isHiddenRings {
                    VStack {
                        HStack {
                            RingsChart(widthOfLine: 3)
                                .environmentObject(data)
                                .environmentObject(ringChartStyle)
                                .disabled(true)
                                .onTapGesture {
                                    isHiddenRings.toggle()
                                }
                                .frame(width: 130, height: 130)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 20)
                        VStack(alignment: .leading) {
                            ForEach(monthAnalytic?.wasts ?? []) { wast in
                                HStack {
                                    Circle()
                                        .foregroundColor(wast.type?.color ?? .brown)
                                        .frame(width: 10, height: 10)
                                    Spacer()
                                        .frame(width: 10, height: 10)
                                    Text("\(wast.type?.name ?? "") - \(wast.amount?.rounded(toPlaces: 2).toString(forCurrencyCode: "RUR") ?? "")")
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
                                .onTapGesture {
                                    isHiddenRings.toggle()
                            }
                                .frame(width: 130, height: 130)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 20)
                        VStack(alignment: .leading) {
                            ForEach(monthAnalytic?.wasts ?? []) { wast in
                                HStack(spacing: 0) {
                                    Circle()
                                        .foregroundColor(wast.type?.color ?? .brown)
                                        .frame(width: 10, height: 10)
                                    Spacer()
                                        .frame(width: 10)
                                        .frame(maxWidth: 10)
                                    Text("\(wast.type?.name ?? "") - \(wast.percent?.rounded(toPlaces: 2).clean ?? "")%")
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
        .background(
            RoundedRectangle(cornerRadius: 30).fill(Color(UIColor.systemBackground))
                .softInnerShadow(RoundedRectangle(cornerRadius: 30), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, spread: 0.05, radius: 2)
        )
    }
}

//struct ChartsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartsView(data: ChartData([10,30,50,1923,294,54]))
//    }
//}
