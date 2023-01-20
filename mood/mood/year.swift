//
//  year.swift
//  Moody
//
//  Created by Stanisław Bożych on 26/11/2022.
//

import Foundation
import SwiftUI

public class Callendar{
    
    var month = [String]()
    var days = [Int]()
    var quantity = [Int]()
    
    var positionX = [[Int]]()
    var positionY = [[Int]]()
    
    public init(){
        setup()
    }
    
    func setup() {
        //MONTH SETUP
        month.append("JANUARY");
        month.append("FEBRUARY");
        month.append("MARCH");
        month.append("APRIL");
        month.append("MAY");
        month.append("JUNE");
        month.append("JULY");
        month.append("AUGUST");
        month.append("SEPTEMBER");
        month.append("OCTOBER");
        month.append("NOVEMBER");
        month.append("DECEMBER");
        
        //FIRST DAYS OF MONTHS
        days.append(120);
        days.append(-40);
        days.append(-40);
        days.append(80);
        days.append(-120);
        days.append(0);
        days.append(80);
        days.append(-80);
        days.append(40);
        days.append(120);
        days.append(-40);
        days.append(40);
        
//        80 - monday (-125)
//        122 - tuesday (-85)
//        164 - wednesday (-45)
//        206 - thursday (0)
//        248 - friday (45)
//        290 - saturday (85)
//        332 - sunday (125)
        
        //quantity of days in a month
        quantity.append(31);
        quantity.append(28);
        quantity.append(31);
        quantity.append(30);
        quantity.append(31);
        quantity.append(30);
        quantity.append(31);
        quantity.append(31);
        quantity.append(30);
        quantity.append(31);
        quantity.append(30);
        quantity.append(31);
        
        
        for j in 0...11{
            var currentStart = days[j];
            var pX = [Int]();
            var pY = [Int]();
            var spacer = 1;
            var rowCounter = 0;
            for i in 1...31{
                if(currentStart + (40*(i-spacer)) <= 125){
                    pX.append(currentStart + (40*(i-spacer)))
                    pY.append(-100 + (40 * rowCounter))
                }
                else{
                    rowCounter+=1;
                    spacer = i;
                    currentStart = -120;
                    pX.append(currentStart + (42*(i-spacer)))
                    pY.append(-100 + (40 * rowCounter))
                }
            }
            positionX.append(pX)
            positionY.append(pY)
        }
    }
}
