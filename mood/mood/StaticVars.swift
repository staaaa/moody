//
//  StaticVars.swift
//  Moody
//
//  Created by Stanisław Bożych on 27/11/2022.
//

import Foundation
import SwiftUI

class DayData: Codable, Equatable, Identifiable{
    static func == (lhs: DayData, rhs: DayData) -> Bool {
        return lhs.dayNumber == rhs.dayNumber && lhs.monthNumber == rhs.monthNumber && lhs.description == rhs.description && lhs.mood == rhs.mood && lhs.photo == rhs.photo
    }
    var monthNumber = 0
    var dayNumber = 0
    var description = "test"
    var mood = 0
    var photo = Data()
    
    init(monthNumber: Int = 0, dayNumber: Int = 0, description: String = "test", mood: Int = 0, photo: Data) {
        self.monthNumber = monthNumber
        self.dayNumber = dayNumber
        self.description = description
        self.mood = mood
        self.photo = photo
    }
}

class CurrentIndex : ObservableObject{
    @Published var index: Int;
    
    init(index: Int) {
        self.index = index
    }
}

class GlobalVars: ObservableObject {
    @Published var isSettings = false
    @Published var isFillDays = false
    @Published var isFilledDay = false
    @Published var isMenu = false
    @Published var currentDay = [0, 0, 0]
    @Published var currentDayDate = "test"
    @Published var colors = Array(repeating: Array(repeating: Color(red: 206/255, green: 206/255, blue: 206/255), count: 31), count: 12)
    @Published var currentColorPalette = 1
    
    //vars for desc modify
    @Published var modDesc = ""
    
    //colors
    //first palette
    @Published var p1color1 = Color(red: 255/255, green: 86/255, blue: 86/255);
    @Published var p1color2 = Color(red: 255/255, green: 112/255, blue: 67/255);
    @Published var p1color3 = Color(red: 255/255, green: 196/255, blue: 107/255);
    @Published var p1color4 = Color(red: 183/255, green: 255/255, blue: 91/255);
    @Published var p1color5 = Color(red: 90/255, green: 242/255, blue: 87/255);

    @Published var p2color1 = Color(red: 28/255, green: 11/255, blue: 26/255);
    @Published var p2color2 = Color(red: 133/255, green: 66/255, blue: 111/255);
    @Published var p2color3 = Color(red: 214/255, green: 152/255, blue: 193/255);
    @Published var p2color4 = Color(red: 255/255, green: 115/255, blue: 208/255);
    @Published var p2color5 = Color(red: 255/255, green: 15/255, blue: 175/255);
    
    @Published var p3color1 = Color(red: 24/255, green: 42/255, blue: 43/255);
    @Published var p3color2 = Color(red: 33/255, green: 110/255, blue: 108/255);
    @Published var p3color3 = Color(red: 71/255, green: 130/255, blue: 179/255);
    @Published var p3color4 = Color(red: 70/255, green: 42/255, blue: 250/255);
    @Published var p3color5 = Color(red: 12/255, green: 30/255, blue: 196/255);

    @Published var p4color1 = Color(red: 43/255, green: 25/255, blue: 16/255);
    @Published var p4color2 = Color(red: 64/255, green: 49/255, blue: 34/255);
    @Published var p4color3 = Color(red: 255/255, green: 180/255, blue: 31/255);
    @Published var p4color4 = Color(red: 255/255, green: 58/255, blue: 28/255);
    @Published var p4color5 = Color(red: 140/255, green: 1/255, blue: 1/255);
    
    @Published var daysDescription : [DayData]
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "ColorPalette"){
            if let decoded = try? JSONDecoder().decode(Int.self, from: data){
                currentColorPalette = decoded
            }
        }
        if let data = UserDefaults.standard.data(forKey: "Descriptions") {
            if let decoded = try? JSONDecoder().decode([DayData].self, from: data) {
                daysDescription = decoded

                for day in daysDescription{
                    if(day.mood == 1){
                        switch(currentColorPalette){
                        case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color1; break;
                        case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color1; break;
                        case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color1; break;
                        case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color1; break;
                        default:colors[day.monthNumber-1][day.dayNumber-1] = p1color1; break;
                        }
                        
                    }
                    else if(day.mood == 2){
                        switch(currentColorPalette){
                        case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color2; break;
                        case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color2; break;
                        case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color2; break;
                        case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color2; break;
                        default:colors[day.monthNumber-1][day.dayNumber-1] = p1color2; break;
                        }
                    }
                    else if(day.mood == 3){
                        switch(currentColorPalette){
                        case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color3; break;
                        case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color3; break;
                        case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color3; break;
                        case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color3; break;
                        default:colors[day.monthNumber-1][day.dayNumber-1] = p1color3; break;
                        }
                    }
                    else if(day.mood == 4){
                        switch(currentColorPalette){
                        case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color4; break;
                        case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color4; break;
                        case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color4; break;
                        case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color4; break;
                        default:colors[day.monthNumber-1][day.dayNumber-1] = p1color4; break;
                        }
                    }
                    else if(day.mood == 5){
                        switch(currentColorPalette){
                        case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color5; break;
                        case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color5; break;
                        case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color5; break;
                        case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color5; break;
                        default:colors[day.monthNumber-1][day.dayNumber-1] = p1color5; break;
                        }
                    }
                }
                return
            }
        }
        daysDescription = []
        currentColorPalette = 1
    }
    
    func save() {
        for day in daysDescription{
            if(day.mood == 1){
                switch(currentColorPalette){
                case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color1; break;
                case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color1; break;
                case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color1; break;
                case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color1; break;
                default:colors[day.monthNumber-1][day.dayNumber-1] = p1color1; break;
                }
                
            }
            else if(day.mood == 2){
                switch(currentColorPalette){
                case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color2; break;
                case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color2; break;
                case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color2; break;
                case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color2; break;
                default:colors[day.monthNumber-1][day.dayNumber-1] = p1color2; break;
                }
            }
            else if(day.mood == 3){
                switch(currentColorPalette){
                case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color3; break;
                case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color3; break;
                case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color3; break;
                case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color3; break;
                default:colors[day.monthNumber-1][day.dayNumber-1] = p1color3; break;
                }
            }
            else if(day.mood == 4){
                switch(currentColorPalette){
                case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color4; break;
                case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color4; break;
                case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color4; break;
                case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color4; break;
                default:colors[day.monthNumber-1][day.dayNumber-1] = p1color4; break;
                }
            }
            else if(day.mood == 5){
                switch(currentColorPalette){
                case 1:colors[day.monthNumber-1][day.dayNumber-1] = p1color5; break;
                case 2:colors[day.monthNumber-1][day.dayNumber-1] = p2color5; break;
                case 3:colors[day.monthNumber-1][day.dayNumber-1] = p3color5; break;
                case 4:colors[day.monthNumber-1][day.dayNumber-1] = p4color5; break;
                default:colors[day.monthNumber-1][day.dayNumber-1] = p1color5; break;
                }
            }
        }
        if let encoded = try? JSONEncoder().encode(daysDescription) {
            UserDefaults.standard.set(encoded, forKey: "Descriptions")
        }
        if let encoded = try? JSONEncoder().encode(currentColorPalette) {
            UserDefaults.standard.set(encoded, forKey: "ColorPalette")
        }
    }
}

class NotificationVars: ObservableObject{
    @Published var notificationsOn = false
    @Published var notificationHour = "20"
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "Notifications") {
            if let decoded = try? JSONDecoder().decode(Bool.self, from: data) {
                notificationsOn = decoded
            }
        }
        if let data = UserDefaults.standard.data(forKey: "NotHour"){
            if let decoded = try? JSONDecoder().decode(String.self, from: data){
                notificationHour = decoded
                return
            }
        }
        notificationsOn = false
        notificationHour = "20"
    }
    func save() {
        if let encoded = try? JSONEncoder().encode(notificationsOn) {
            UserDefaults.standard.set(encoded, forKey: "Notifications")
        }
        if let encoded = try? JSONEncoder().encode(notificationHour) {
            UserDefaults.standard.set(encoded, forKey: "NotHour")
        }
    }
}
