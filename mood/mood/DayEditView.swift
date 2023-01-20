//
//  DayEditView.swift
//  mood
//
//  Created by Stanisław Bożych on 11/12/2022.
//

import SwiftUI

struct DayEditView: View {
    @EnvironmentObject private var globalVars: GlobalVars
    @State private var showAlert = false
    @State private var dayDesc = "desc"
    @State private var photo: UIImage? = nil
    
    let darkGrey : Color = Color(red: 62/255, green: 62/255, blue: 62/255);
    let grey : Color = Color(red: 86/255, green: 86/255, blue: 86/255);
    let lightGrey : Color = Color(red: 117/255, green: 117/255, blue: 117/255);
    let dayGrey : Color = Color(red: 206/255, green: 206/255, blue: 206/255);
    let white : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    let orange : Color = Color(red: 255/255, green: 112/255, blue: 67/255);
    
    func modify(){
        withAnimation(){
            globalVars.isFilledDay = false
        }
    }
    
    var hasNotch: Bool {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
    }
    
    var body: some View {
        VStack(){
            VStack{
                HStack{
                    Image("arrow-back")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .padding(.top, 30.0)
                        .padding(.leading, 30.0)
                        .onTapGesture(){
                            withAnimation(){
                                globalVars.isDayedit = false
                            }
                        }
                    Spacer()
                    Image("trash-solid")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .padding(.top, 30.0)
                        .padding(.trailing, 30.0)
                        .onTapGesture(){
                            withAnimation(){
                                showAlert = true
                            }
                        }
                        .alert(isPresented: $showAlert){
                            Alert(title: Text("WARNING!"),
                                  message: Text("Are you sure you want to delete all data from this day?"),
                                  primaryButton: .default(Text("Go back")),
                                  secondaryButton: .destructive(Text("Delete"), action: {
                                    withAnimation(){
                                        if let day = globalVars.daysDescription.first(where: {$0.monthNumber == globalVars.currentDay[0] && $0.dayNumber == globalVars.currentDay[1]}){
                                            let index = globalVars.daysDescription.firstIndex(of: day)
                                            globalVars.daysDescription.remove(at: index!)
                                            globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = dayGrey
                                            globalVars.save()
                                            globalVars.isFilledDay = false
                                        }
                                        showAlert = false;
                                    }
                                }))
                        }
                }
                .padding(.top, hasNotch ? 0 : 40)
                .ignoresSafeArea()
                .frame(height: 0.0)
                HStack{
                    Text(globalVars.currentDayDate)
                        .font(.custom("Bebas Neue", size: 36))
                        .foregroundColor(white)
                        .padding(.bottom, 5)
                }
            }.background(darkGrey)
                .shadow(radius: 30)
            Text("THIS IS HOW YOUR DAY WENT:")
                .font(.custom("Bebas Neue", size: 24))
                .foregroundColor(white)
                .padding(.top, 10.0)
            Text(dayDesc)
                .font(.custom("Bebas Neue", size: 20))
                .foregroundColor(white)
                .padding(25.0)
            if let day = globalVars.daysDescription.first(where: {$0.monthNumber == globalVars.currentDay[0] && $0.dayNumber == globalVars.currentDay[1]}){
                if(UIImage(data:day.photo) != nil){
                    Image(uiImage: UIImage(data:day.photo)!)
                        .resizable()
                        .cornerRadius(20.0)
                        .scaledToFit()
                        .frame(width: 340.0, height: 340.0)
                }
            }
            Spacer()
            Button(action: modify){
                Text("CHANGE DAY DESCRIPTION")
                    .font(.custom("Bebas Neue", size: 30))
                    .frame(width:300, height:50)
            }
            .frame(width:300, height:50)
            .background(orange)
            .cornerRadius(30)
            .font(.system(size:24))
            .foregroundColor(white)
            if(!hasNotch){
                VStack{
                    
                }
                .frame(width:300, height:10)
            }
        }.background(grey)
            .statusBar(hidden: true)
            .onAppear(){
                if let day = globalVars.daysDescription.first(where: {$0.monthNumber == globalVars.currentDay[0] && $0.dayNumber == globalVars.currentDay[1]}){
                    dayDesc  = day.description
                }
            }
    }
}

struct DayEditView_Previews: PreviewProvider {
    static var previews: some View {
        DayEditView()
    }
}
