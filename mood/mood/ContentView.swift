//
//  ContentView.swift
//  Moody
//
//  Created by Stanisław Bożych on 26/11/2022.
//

import SwiftUI

struct MainView: View {
    
    //colors
    let darkGrey : Color = Color(red: 62/255, green: 62/255, blue: 62/255);
    let grey : Color = Color(red: 86/255, green: 86/255, blue: 86/255);
    let lightGrey : Color = Color(red: 117/255, green: 117/255, blue: 117/255);
    let dayGrey : Color = Color(red: 206/255, green: 206/255, blue: 206/255);
    let white : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    
    let years = Callendar();
    
    @EnvironmentObject private var globalVars: GlobalVars
    
    var hasNotch: Bool {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
    }
    
    var body: some View {
        VStack(){
            VStack{
                HStack{
                    Image("bars-solid")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .padding(.top, 30.0)
                        .padding(.leading, 30.0)
                    Spacer()
                    Image("gear-solid")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .padding(.top, 30.0)
                        .padding(.trailing, 30.0)
                        .onTapGesture(){
                            withAnimation(){
                                globalVars.isSettings = true
                            }
                        }
                }
                .ignoresSafeArea()
                .padding(.top, hasNotch ? 0 : 40)
                .frame(height: 0.0)
                HStack{
                    Text("2023")
                        .font(.custom("Bebas Neue", size: 36))
                        .foregroundColor(white)
                        .padding(.bottom, 5)
                }
            }.background(darkGrey)
                .shadow(radius: 30)
            ScrollView(showsIndicators: false){
                VStack{}.frame(height: 20)
                MonthView()
                    .environmentObject(globalVars)
            }
            .padding(.top, -7.0)
        }.background(grey)
            .statusBar(hidden: true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
