//
//  DetailsOfCell.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI

struct DetailsOfCell: View {
    
    @Binding var discharge: Discharge?
    
    var body: some View {
        VStack {
            if let discharge = discharge {
                DetailsOfCellGeneral(discharge: discharge)
                RequisitesView(discharge: discharge)
            }
            
            Spacer()
        }
    }
}

struct DetailsOfCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailsOfCell(discharge: .constant(Discharge.data))
    }
}

struct DetailsOfCellGeneral: View {
    
    let discharge: Discharge
    
    var body: some View {
        Spacer()
            .frame(height: 20)
        DetailsOfCellLogo()
        DetailsOfCellAmount(type: discharge.type ?? .inside, amount: discharge.getAmountString ?? "")
        DetailsOfCellCaption(label: discharge.operationType?.name ?? "")
        DetailsOfCellTitle2(label: discharge.fastPaymentData?.foreignName ?? "")
        DetailsOfCellSemibold(label: discharge.fastPaymentData?.foreignBankName ?? "")
        DetailsOfCellCaption(label: discharge.getTranDateString ?? "")
        Spacer()
            .frame(height: 20)
        DetailsOfCellSubheadline(label: discharge.comment ?? "")
    }
}

struct DetailsOfCellHeader: View {
    
    let type: TypeOfDischarge
    
    var body: some View {
        Text(type.name)
            .font(.headline)
            .fontWeight(.thin)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .padding(.horizontal)
    }
}

struct DetailsOfCellAmount: View {
    
    let type: TypeOfDischarge
    let amount: String
    
    var body: some View {
        Text(amount)
            .font(.title)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .foregroundColor(type == .inside ? .green : .red)
            .padding(.horizontal)
    }
}

struct DetailsOfCellTitle2: View {
    
    let label: String
    
    var body: some View {
        Text(label)
            .font(.title2)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .padding(.horizontal)
    }
}

struct DetailsOfCellSemibold: View {
    
    let label: String
    
    var body: some View {
        Text(label)
            .font(.subheadline)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .padding(.horizontal)
    }
}

struct DetailsOfCellCaption: View {
    
    let label: String
    
    var body: some View {
        Text(label)
            .font(.caption)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .padding(.horizontal)
    }
}

struct DetailsOfCellSubheadline: View {
    
    let label: String
    
    var body: some View {
        Text(label)
            .font(.subheadline)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
    }
}

struct RequisitesView: View {
    
    let discharge: Discharge
    
    var body: some View {
        Spacer()
            .frame(height: 20)
        HStack {
            Spacer()
                .frame(width: 20)
            Text("Реквизиты")
                .font(.caption)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .lineLimit(1)
            Spacer()
        }
        Spacer()
            .frame(height: 12)
        HStack {
            DetailsOfCellSemibold(label: "БИК: \(discharge.fastPaymentData?.foreignBankBIC ?? "-")")
            Spacer()
        }
        Spacer()
            .frame(height: 12)
        HStack {
            DetailsOfCellSemibold(label: "Номер счета: \(discharge.accountNumber ?? "-")")
            Spacer()
        }
        Spacer()
            .frame(height: 12)
    }
}

struct DetailsOfCellLogo: View {
    
    var body: some View {
        
        HStack {
            Spacer()
                .frame(minWidth: 20)
            Circle()
                .frame(width: 120, height: 120)
            Spacer()
                .frame(minWidth: 20)
        }
        
        
    }
}
