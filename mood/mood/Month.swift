//
//  Month.swift
//  mood
//
//  Created by Stanisław Bożych on 05/12/2022.
//

import SwiftUI

struct MonthView: View {
    let darkGrey : Color = Color(red: 62/255, green: 62/255, blue: 62/255);
    let grey : Color = Color(red: 86/255, green: 86/255, blue: 86/255);
    let lightGrey : Color = Color(red: 117/255, green: 117/255, blue: 117/255);
    let dayGrey : Color = Color(red: 206/255, green: 206/255, blue: 206/255);
    let white : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    
    @EnvironmentObject private var globalVars: GlobalVars
    
    let years = Callendar();
    
    var body: some View {
        ForEach(0..<12) { index in
            Text(years.month[index])
                .font(.custom("Bebas Neue", size: 36))
                .foregroundColor(white)
                .padding(.bottom, -8)
            ZStack{
                RoundedRectangle(cornerRadius: 45, style: .continuous)
                    .fill(lightGrey)
                    .frame(width: 336, height: 336)
                    .shadow(radius: 5, y:20)
                DayView(Current: index)
                    .environmentObject(globalVars)
            }
        }
    }
}

struct Month_Previews: PreviewProvider {
    static var previews: some View {
        MonthView()
    }
}
