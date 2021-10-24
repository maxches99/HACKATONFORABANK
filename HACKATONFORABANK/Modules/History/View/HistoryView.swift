//
//  ContentView.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import SwiftUI
import Introspect
import Neumorphic

struct HistoryView: View {
    
    @ObservedObject var output: HistoryPresenter = HistoryPresenter()
    
    @State var bottomSheetPosition: BottomSheetPosition = .hidden
    
    @State var newDischargeViewPosition: CustomBottomSheetPosition = .hidden
    
    @State var isShowLoss = true
    
    var refreshControl = UIRefreshControl()
    
    @State var tableView: UITableView?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ZStack {
                        Text("История")
                            .font(.title2)
                            .fontWeight(.heavy)
                        HStack {
                            Spacer()
                            Button(action: {
                                bottomSheetPosition = .middle
                            }) {
                                Image(systemName: "slider.horizontal.3")
                                    .font(.title2)
                                    .foregroundColor(Color(UIColor.label))
                                
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
                VStack {
                    Spacer()
                        .frame(height: 60)
                    
                    
                    
                    switch output.state {
                    case true:
                        List {
                            switch output.stateOfAnalytic {
                            case true:
                                TabView {
                                    AllSummView(summOut: output.monthAnalytics?.loss?.rounded(toPlaces: 2) ?? 0, summIn: output.monthAnalytics?.arrival?.rounded(toPlaces: 2) ?? 0) {
                                        newDischargeViewPosition = .middle
                                    }
                                    .onTapGesture(perform: {
                                        isShowLoss.toggle()
                                    })
                                    .frame(width: geometry.size.width - 40)
                                    .frame(maxWidth: geometry.size.width - 40)
                                    .frame(height: 400)
                                    .tag(1)
                                    ChartsView(monthAnalytic: output.monthAnalytics)
                                    .frame(width: geometry.size.width - 40)
                                    .frame(maxWidth: geometry.size.width - 40)
                                    .frame(height: 400)
                                    .tag(2)
                                    ChartsViewByUsers(peopleAnalytic: output.peoples)
                                    .frame(width: geometry.size.width - 40)
                                    .frame(maxWidth: geometry.size.width - 40)
                                    .frame(height: 400)
                                    .tag(3)
                                }
                                .tabViewStyle(PageTabViewStyle())
                                .frame(height: 400)
                                .frame(maxWidth: geometry.size.width - 40)
                            case false:
                                EmptyView()
                            }
                            
                            
                            Spacer()
                                .frame(height: 20)
                            HStack {
                                Text("Все операции")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            ForEach(output.sections) { section in
                                HStack {
                                    Text(section)
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.gray)
                                        .padding(.vertical)
                                    Spacer()
                                }
                                ForEach(output.grouppedList[section] ?? []) { item in
                                    Button(action: {
                                        output.currentDischarge = item
                                        
                                    }) {
                                        HistoryCell(discharge: item)
                                    }
                                    .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                                    .buttonStyle(HiddenCellButton())
                                    .listRowSeparator(.hidden)
                                    
                                }
                            }
                            if output.isEnabledPagination {
                                Spacer()
                                    .frame(height: 20)
                                HStack {
                                    Spacer()
                                    ProgressView(value: 0.5)
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .onAppear(perform: {
                                            output.loadDataPerPage()
                                    })
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                }
                            }
                            Spacer()
                                .frame(height: 20)
                            
                        }
                        .listStyle(.plain)
                        .introspectTableView { tableView in
                            self.tableView = tableView
                            tableView.isScrollEnabled = true
                            tableView.bounces = true
                            refreshControl.addTarget(
                                output,
                                action: #selector(output.refresh(_:)),
                                for: .valueChanged
                            )
                            tableView.addSubview(refreshControl)
                            tableView.separatorStyle = .none
                            tableView.separatorColor = .none
                            if #available(iOS 15.0, *) {
                                tableView.sectionHeaderTopPadding = .zero
                            }
                        }
                        .valueChanged(value: output.spinnerState, onChange: { value in
                            if value == false {
                                refreshControl.endRefreshing()
                            }
                        })
                        .frame(width: geometry.size.width)
                    case false:
                        ProgressView(value: 0.5)
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    Spacer()
                }
                .edgesIgnoringSafeArea(.bottom)
                .bottomSheet(bottomSheetPosition: $bottomSheetPosition, options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .backgroundBlur(effect: .dark), .cornerRadius(16), .noDragIndicator, .noBottomPosition], headerContent: {
                    HStack(alignment: .bottom) {
                        Text("Фильтры и группировка")
                            .font(.title).bold()
                    }
                    
                }) {
                    if output.stateOfPeoples {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .edgesIgnoringSafeArea(.all)
                            FiltersView(peoples: $output.peoples) { filters in
                                output.filters = filters
                            }
                        }
                    } else {
                        EmptyView()
                    }
                }
                .bottomSheet(bottomSheetPosition: $newDischargeViewPosition, options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .backgroundBlur(effect: .dark), .cornerRadius(16), .noDragIndicator, .noBottomPosition], headerContent: {
                    HStack(alignment: .bottom) {
                        Text("Добавить новую операцию?")
                            .font(.title).bold()
                    }
                    
                }) {
                    AddNewDischarge()
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                .sheet(item: $output.currentDischarge, onDismiss: {
                    output.currentDischarge = nil
                }) {_ in
                    DetailsOfCell(discharge: $output.currentDischarge)
            }
            }
            
        }
        .onAppear(perform: {
            output.loadDataPerPage()
            output.interactor.getMonthAnalytics()
            output.interactor.getPeoples()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
        Group {
            HistoryView()
                .preferredColorScheme(.dark)
                .dynamicTypeSize(.xxxLarge)
        }
    }
}


struct HiddenCellButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HiddenCellButtonView(configuration: configuration)
    }
}

private extension HiddenCellButton {
    struct HiddenCellButtonView: View {
        // tracks if the button is enabled or not
        @Environment(\.isEnabled) var isEnabled
        // tracks the pressed state
        let configuration: HiddenCellButton.Configuration
        
        var body: some View {
            return configuration.label
            
            // make the button a bit more translucent when pressed
                .opacity(configuration.isPressed ? 1 : 1.0)
            // make the button a bit smaller when pressed
                .scaleEffect(configuration.isPressed ? 1 : 1.0)
        }
    }
}

import Combine

extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }
}
