//
//  AddNewDischarge.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI
import Neumorphic

struct AddNewDischarge: View {
    
    @State var text = ""
    @State var textComment = ""
    @State var date = Date()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                TextField("Введите название операции", text: $text)
                    .padding(.horizontal, 20)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30).fill(Color(UIColor.systemBackground))
                    .softInnerShadow(RoundedRectangle(cornerRadius: 30), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, spread: 0.05, radius: 2)
            )
            .padding(.horizontal, 20)
            Spacer()
                .frame(height: 20)
            HStack {
                DatePicker(selection: $date, label: {
                    Text("Время операции")
                        .font(.callout)
                        .fontWeight(.ultraLight)
                        .multilineTextAlignment(.leading)
                    
                })
            }
            .padding(.horizontal, 20)
            Spacer()
                .frame(minHeight: 20)
            HStack {
                Spacer()
                    .frame(width: 20)
                Button(action: {}) {
                    Text("Сохранить операцию")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 48)
                        .foregroundColor(.red)
                )
                .frame(height: 48)
                Spacer()
                    .frame(width: 20)
            }
            Spacer()
                .frame(height: 15)
        }
    }
}

struct AddNewDischarge_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                Spacer()
            }
            .bottomSheet(bottomSheetPosition: .constant(CustomBottomSheetPosition.middle), options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .noDragIndicator], headerContent: {
                                //The name of the book as the heading and the author as the subtitle with a divider.
                                HStack(alignment: .bottom) {
                                    Text("Добавить новую операцию?")
                                        .font(.title).bold()
                                }

                }) {
                    AddNewDischarge()
                    
            }
            Group {
                VStack {
                    Spacer()
                }
                .bottomSheet(bottomSheetPosition: .constant(CustomBottomSheetPosition.middle), options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .noDragIndicator], headerContent: {
                    //The name of the book as the heading and the author as the subtitle with a divider.
                    HStack(alignment: .bottom) {
                        Text("Добавить новую операцию?")
                            .font(.title).bold()
                    }
                    
                }) {
                    AddNewDischarge()
                    
            }
            }
            .previewDevice("iPhone 6s")
        }
    }
}

enum CustomBottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.975, topMiddle = 0.7, middle = 0.5, middleBottom = 0.3, hidden = 0
}
