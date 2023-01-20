//
//  SettingsView.swift
//  Moody
//
//  Created by Stanisław Bożych on 27/11/2022.
//

import SwiftUI

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization(hourOfNotification: String) {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (sucess, error) in
            if(sucess){
                self.scheduleNotification(hourOfNotification: hourOfNotification)
            }
            else{
                print("ERROR")
            }
        }
    }
    func scheduleNotification(hourOfNotification: String) {
        let content = UNMutableNotificationContent()
        content.title = "The day ends soon!"
        content.body =  "Please remeber to describe today's day!"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = Int(hourOfNotification)
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    func cancelNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct SettingsView: View {
    
    @EnvironmentObject private var globalVars: GlobalVars
    let darkGrey : Color = Color(red: 62/255, green: 62/255, blue: 62/255);
    let grey : Color = Color(red: 86/255, green: 86/255, blue: 86/255);
    let lightGrey : Color = Color(red: 117/255, green: 117/255, blue: 117/255);
    let dayGrey : Color = Color(red: 206/255, green: 206/255, blue: 206/255);
    let white : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    let orange : Color = Color(red: 255/255, green: 112/255, blue: 67/255);
    
    @StateObject var notificationVars = NotificationVars()
//    @State private var notificationHour = "20"
    @State private var showWrongHourAlert = false
    
    func resetNotficationHour(){
        notificationVars.notificationHour = "20"
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
                                globalVars.isSettings = false
                            }
                        }
                    Spacer()
                }
                .padding(.top, hasNotch ? 0 : 40)
                .ignoresSafeArea()
                .frame(height: 0.0)
                HStack{
                    Text("SETTINGS")
                        .font(.custom("Bebas Neue", size: 36))
                        .foregroundColor(white)
                        .padding(.bottom, 5)
                }
            }.background(darkGrey)
                .shadow(radius: 30)
            VStack{
                Toggle(isOn: $notificationVars.notificationsOn) {
                    Text("Send daily reminders about filling your day's description.")
                }
                .tint(orange)
                .padding(30)
                .font(.custom("Bebas Neue", size: 24))
                .foregroundColor(white)
                .onChange(of: notificationVars.notificationsOn) { value in
                    let digitsCharacters = CharacterSet(charactersIn: "0123456789")
                    if(!CharacterSet(charactersIn: notificationVars.notificationHour).isSubset(of: digitsCharacters)){
                        showWrongHourAlert = true
                    }
                    else{
                        if(Int(notificationVars.notificationHour) ?? -1 < 0 || Int(notificationVars.notificationHour) ?? -1 >= 24){
                            showWrongHourAlert = true
                        }
                        else{
                            notificationVars.save()
                            if(notificationVars.notificationsOn){
                                NotificationManager.instance.requestAuthorization(hourOfNotification: notificationVars.notificationHour)
                            }
                            else {
                                NotificationManager.instance.cancelNotifications()
                            }
                        }
                    }
                }
                HStack{
                    Text("Hour of notification:")
                        .font(.custom("Bebas Neue", size: 24))
                        .foregroundColor(white)
                    Spacer()
                    TextField(
                            notificationVars.notificationHour,
                            text: $notificationVars.notificationHour
                    )
                    .onChange(of: notificationVars.notificationHour){ value in
                        notificationVars.notificationsOn = false
                    }
                    .alert(isPresented: $showWrongHourAlert){
                        Alert(
                            title: Text("ERROR!"),
                            message: Text("The hour of the notification must be a number smaller then 23 and higher then 0."),
                            dismissButton: .default(
                                Text("ROGER THAT!"),
                                action: resetNotficationHour
                            )
                        )
                    }
                    .font(.custom("Bebas Neue", size: 24))
                    .foregroundColor(white)
                    .background(darkGrey)
                    .cornerRadius(10)
                    .frame(width:40)
                    .multilineTextAlignment(.center)
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 10)
                .padding(.bottom, 20)
                Text("First color palette")
                    .padding(20)
                    .font(.custom("Bebas Neue", size: 30))
                    .foregroundColor(white)
                    .background(globalVars.currentColorPalette == 1 ? darkGrey : grey)
                    .cornerRadius(15)
                    .onTapGesture {
                        globalVars.currentColorPalette = 1
                        globalVars.save()
                    }
                Text("Second color palette")
                    .padding(20)
                    .font(.custom("Bebas Neue", size: 30))
                    .foregroundColor(white)
                    .background(globalVars.currentColorPalette == 2 ? darkGrey : grey)
                    .cornerRadius(15)
                    .onTapGesture {
                        globalVars.currentColorPalette = 2
                        globalVars.save()
                    }
                Text("Third color palette")
                    .padding(20)
                    .font(.custom("Bebas Neue", size: 30))
                    .foregroundColor(white)
                    .background(globalVars.currentColorPalette == 3 ? darkGrey : grey)
                    .cornerRadius(15)
                    .onTapGesture {
                        globalVars.currentColorPalette = 3
                        globalVars.save()
                    }
                Text("Fourth color palette")
                    .padding(20)
                    .font(.custom("Bebas Neue", size: 30))
                    .foregroundColor(white)
                    .background(globalVars.currentColorPalette == 4 ? darkGrey : grey)
                    .cornerRadius(15)
                    .onTapGesture {
                        globalVars.currentColorPalette = 4
                        globalVars.save()
                    }
            }
            
            Spacer()
        }.background(grey)
            .statusBar(hidden: true)
            .toggleStyle(.switch)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
