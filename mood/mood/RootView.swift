//
//  RootView.swift
//  Moody
//
//  Created by Stanisław Bożych on 27/11/2022.
//

import SwiftUI

struct RootView: View {
    @StateObject var globalVars = GlobalVars()
    let grey : Color = Color(red: 86/255, green: 86/255, blue: 86/255);
    var body: some View {
        VStack{
            if(globalVars.isSettings){
                SettingsView()
                    .environmentObject(globalVars)
                    .transition(.move(edge: .trailing))
            }
            else if(globalVars.isFillDays){
                DayFillView()
                    .environmentObject(globalVars)
                    .transition(.move(edge: .trailing))
            }
            else if(globalVars.isFilledDay){
                DayFilledView()
                    .environmentObject(globalVars)
                    .transition(.move(edge: .trailing))
            }
            else{
                MainView()
                    .environmentObject(globalVars)
                    .transition(.move(edge: .leading))
            }
        }.background(grey)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
