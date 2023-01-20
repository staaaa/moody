//
//  DayFillView.swift
//  Moody
//
//  Created by Stanisław Bożych on 30/11/2022.
//

import SwiftUI
import PhotosUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct DayFillView: View {
    @EnvironmentObject private var globalVars: GlobalVars
//    @State private var desc: String = ""
    @State private var moodPoint = 0;
    @State private var showAlert = false
    @State private var showNotAllFilledAlert = false
    @State private var showPhotoSelectedAlert = false
    
    //image handling
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedPhotoData = Data()
    
    let darkGrey : Color = Color(red: 62/255, green: 62/255, blue: 62/255);
    let grey : Color = Color(red: 86/255, green: 86/255, blue: 86/255);
    let lightGrey : Color = Color(red: 117/255, green: 117/255, blue: 117/255);
    let dayGrey : Color = Color(red: 206/255, green: 206/255, blue: 206/255);
    let white : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    let orange : Color = Color(red: 255/255, green: 112/255, blue: 67/255);
    
    @State var colorVeryHappy : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    @State var colorHappy : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    @State var colorMeh : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    @State var colorSlightSad : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    @State var colorSad : Color = Color(red: 242/255, green: 242/255, blue: 242/255);
    
    var hasNotch: Bool {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
    }
    
    init() {
        UITextView.appearance().textContainerInset =
             UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func save(){
        if(moodPoint != 0)
        {
            if let day = globalVars.daysDescription.first(where: {$0.monthNumber == globalVars.currentDay[0] && $0.dayNumber == globalVars.currentDay[1]}){
                let index = globalVars.daysDescription.firstIndex(of: day)
                globalVars.daysDescription.remove(at: index!)
            }
            globalVars.daysDescription.append(DayData(monthNumber: globalVars.currentDay[0], dayNumber: globalVars.currentDay[1], description: globalVars.modDesc, mood: moodPoint, photo: selectedPhotoData))
            if(moodPoint == 1){
                switch(globalVars.currentColorPalette){
                case 1:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color1; break;
                case 2:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p2color1; break;
                case 3:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p3color1; break;
                case 4:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p4color1; break;
                default:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color1; break;
                }
            }
            else if(moodPoint == 2){
                switch(globalVars.currentColorPalette){
                case 1:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color2; break;
                case 2:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p2color2; break;
                case 3:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p3color2; break;
                case 4:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p4color2; break;
                default:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color2; break;
                }
            }
            else if(moodPoint == 3){
                switch(globalVars.currentColorPalette){
                case 1:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color3; break;
                case 2:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p2color3; break;
                case 3:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p3color3; break;
                case 4:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p4color3; break;
                default:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color3; break;
                }
            }
            else if(moodPoint == 4){
                switch(globalVars.currentColorPalette){
                case 1:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color4; break;
                case 2:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p2color4; break;
                case 3:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p3color4; break;
                case 4:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p4color4; break;
                default:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color4; break;
                }
            }
            else if(moodPoint == 5){
                switch(globalVars.currentColorPalette){
                case 1:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color5; break;
                case 2:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p2color5; break;
                case 3:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p3color5; break;
                case 4:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p4color5; break;
                default:globalVars.colors[globalVars.currentDay[0]-1][globalVars.currentDay[1]-1] = globalVars.p1color5; break;
                }
            }

            globalVars.save()
            showAlert = true
        }
        else
        {
            showNotAllFilledAlert = true
        }
    }
    
    func changeView(){
        withAnimation(){
            globalVars.isFillDays = false
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
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
                                    globalVars.isFillDays = false
                                }
                            }
                        Spacer()
                    }
                    .padding(.top, hasNotch ? 0 : 50)
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
                Text("HOW WAS YOUR DAY TODAY?")
                    .font(.custom("Bebas Neue", size: 24))
                    .foregroundColor(white)
                    .padding(.top, 10.0)
                    .alert(isPresented: $showNotAllFilledAlert){
                        Alert(
                            title: Text("CAN'T SAVE!"),
                            message: Text("Your day description haven't been saved. You at least need to pick your mood that day to save."),
                            dismissButton: .default(
                                Text("ok :(")
                            )
                        )
                    }
                HStack{
                    Image("mood-sad")
                        .resizable()
                        .scaledToFit()
                        .frame(width:50, height:50)
                        .padding(5)
                        .background(moodPoint == 1 ? colorSad : grey)
                        .cornerRadius(50)
                        .onTapGesture {
                            moodPoint = 1
                            switch(globalVars.currentColorPalette){
                                case 1: colorSad = globalVars.p1color1; break;
                                case 2: colorSad = globalVars.p2color1; break;
                                case 3: colorSad = globalVars.p3color1; break;
                                case 4: colorSad = globalVars.p4color1; break;
                                default: colorSad = globalVars.p1color1; break;
                            }
                        }
                    Image("mood-slight-sad")
                        .resizable()
                        .frame(width:50, height:50)
                        .padding(5)
                        .background(moodPoint == 2 ? colorSlightSad : grey)
                        .cornerRadius(50)
                        .onTapGesture {
                            moodPoint = 2
                            switch(globalVars.currentColorPalette){
                                case 1: colorSlightSad = globalVars.p1color2; break;
                                case 2: colorSlightSad = globalVars.p2color2; break;
                                case 3: colorSlightSad = globalVars.p3color2; break;
                                case 4: colorSlightSad = globalVars.p4color2; break;
                                default: colorSlightSad = globalVars.p1color2; break;
                            }
                        }
                    Image("mood-meh")
                        .resizable()
                        .frame(width:50, height:50)
                        .padding(5)
                        .background(moodPoint == 3 ? colorMeh : grey)
                        .cornerRadius(50)
                        .onTapGesture {
                            moodPoint = 3
                            switch(globalVars.currentColorPalette){
                                case 1: colorMeh = globalVars.p1color3; break;
                                case 2: colorMeh = globalVars.p2color3; break;
                                case 3: colorMeh = globalVars.p3color3; break;
                                case 4: colorMeh = globalVars.p4color3; break;
                                default: colorMeh = globalVars.p1color3; break;
                            }
                        }
                    Image("mood-happy")
                        .resizable()
                        .frame(width:50, height:50)
                        .padding(5)
                        .background(moodPoint == 4 ? colorHappy : grey)
                        .cornerRadius(50)
                        .onTapGesture {
                            moodPoint = 4
                            switch(globalVars.currentColorPalette){
                                case 1: colorHappy = globalVars.p1color4; break;
                                case 2: colorHappy = globalVars.p2color4; break;
                                case 3: colorHappy = globalVars.p3color4; break;
                                case 4: colorHappy = globalVars.p4color4; break;
                                default: colorHappy = globalVars.p1color4; break;
                            }
                        }
                    Image("mood-very-happy")
                        .resizable()
                        .frame(width:50, height:50)
                        .padding(5)
                        .background(moodPoint == 5 ? colorVeryHappy : grey)
                        .cornerRadius(50)
                        .onTapGesture {
                            moodPoint = 5
                            switch(globalVars.currentColorPalette){
                                case 1: colorVeryHappy = globalVars.p1color5; break;
                                case 2: colorVeryHappy = globalVars.p2color5; break;
                                case 3: colorVeryHappy = globalVars.p3color5; break;
                                case 4: colorVeryHappy = globalVars.p4color5; break;
                                default: colorVeryHappy = globalVars.p1color5; break;
                            }
                        }
                }
                Text("DESCRIBE WHAT YOU'VE BEEN UP TO!")
                    .font(.custom("Bebas Neue", size: 24))
                    .foregroundColor(white)
                    .padding(.bottom, -10.0)
                    .multilineTextAlignment(.center)
                if #available(iOS 16.0, *) {
                    TextEditor(text: $globalVars.modDesc)
                        .scrollContentBackground(.hidden)
                        .background(darkGrey)
                        .cornerRadius(30)
                        .frame(width:300.0, height: hasNotch ? 300 : 200)
                        .lineSpacing(10)
                        .padding(30)
                        .foregroundColor(.white)
                        .font(.system(size:24))
                } else {
                    TextEditor(text: $globalVars.modDesc)
                        .background(darkGrey)
                        .cornerRadius(30)
                        .frame(width:300.0, height: hasNotch ? 300 : 200)
                        .lineSpacing(10)
                        .foregroundColor(.black)
                        .font(.system(size:24))
                }
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if(selectedItem != nil){
                        Label("Photo selected.", systemImage: "photo")
                            .font(.custom("Bebas Neue", size: 18))
                    }
                    else{
                        Label("Select a photo:", systemImage: "photo")
                            .font(.custom("Bebas Neue", size: 18))
                    }
                   
                }
                .alert(isPresented: $showPhotoSelectedAlert){
                    Alert(
                        title: Text("SAVED!"),
                        message: Text("The picked photo has been saved."),
                        dismissButton: .default(
                            Text("GREAT!")
                        )
                    )
                }
                .tint(orange)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .onChange(of: selectedItem) { newItem in
                   Task {
                       if let data = try? await newItem?.loadTransferable(type:Data.self) {
                           selectedPhotoData = data
                           showPhotoSelectedAlert = true
                       }
                   }
                }
                Spacer()
                Button(action: save){
                    Text("SAVE")
                        .font(.custom("Bebas Neue", size: 34))
                        .frame(width:300, height:50)
                }
                .frame(width:300, height:50)
                .background(orange)
                .cornerRadius(30)
                .font(.system(size:24))
                .foregroundColor(white)
                .alert(isPresented: $showAlert){
                    Alert(
                        title: Text("SAVED!"),
                        message: Text("Your day description have been saved."),
                        dismissButton: .default(
                            Text("GREAT!"),
                            action: changeView
                        )
                    )
                }
                if(!hasNotch){
                    VStack{
                        
                    }
                    .frame(width:300, height:10)
                }
            }.background(grey)
                .statusBar(hidden: true)
                .onTapGesture {
                    self.endEditing()
                }
        }
}

struct DayFillView_Previews: PreviewProvider {
    static var previews: some View {
        DayFillView()
    }
}
