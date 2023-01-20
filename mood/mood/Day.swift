//
//  day.swift
//  mood
//
//  Created by Stanisław Bożych on 05/12/2022.
//

import SwiftUI

struct DayView: View {
    let darkGrey : Color = Color(red: 62/255, green: 62/255, blue: 62/255);
    let grey : Color = Color(red: 86/255, green: 86/255, blue: 86/255);
    let lightGrey : Color = Color(red: 117/255, green: 117/255, blue: 117/255);
    let dayGrey : Color = Color(red: 206/255, green: 206/255, blue: 206/255);
    let white : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    
    @State var Current: Int
    @EnvironmentObject private var globalVars: GlobalVars
    
    let years = Callendar();
    
    var body: some View {
        ForEach(0..<years.quantity[Current], id: \.self){ value in
            let x = CGFloat(years.positionX[Current][value])
            let y = CGFloat(years.positionY[Current][value])
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(globalVars.colors[Current][value])
                .frame(width: 35, height: 35)
                .offset(x: x, y: y)
                .shadow(radius: 10, y:20)
                .onTapGesture(){
                    withAnimation(){
                        if(!globalVars.daysDescription.contains(where: {$0.monthNumber == Current+1 && $0.dayNumber == value+1})){
                            globalVars.isFillDays = true
                            globalVars.modDesc = ""
                            globalVars.currentDay[0] = Current+1
                            globalVars.currentDay[1] = value+1
                            globalVars.currentDay[2] = 2023
                            globalVars.currentDayDate = String(value+1) + "/" + String(Current+1) + "/" + String(2023)
                        }
                        else{
                            globalVars.currentDay[0] = Current+1
                            globalVars.currentDay[1] = value+1
                            globalVars.currentDay[2] = 2023
                            globalVars.currentDayDate = String(value+1) + "/" + String(Current+1) + "/" + String(2023)
                            globalVars.isFilledDay = true
                        }
                    }
                }
            Text(String(value+1))
                .font(.custom("Bebas Neue", size: 25))
                .offset(x: x, y: y)
                .foregroundColor(.white);
        }
    }
}

struct day_Previews: PreviewProvider {
    static var previews: some View {
        DayView(Current: 0)
    }
}
