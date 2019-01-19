//
//  Utils.swift
//  Smack
//
//  Created by lucas on 19/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit


public class Utils {
    
  public static func colorImage(color : String) -> UIColor {
        let scanner = Scanner(string: color)
        let spiked = CharacterSet(charactersIn: "[], ")
        let sp = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = spiked
        var r,g, b, a : NSString?
        scanner.scanUpToCharacters(from: sp, into: &r)
        scanner.scanUpToCharacters(from: sp, into: &g)
        scanner.scanUpToCharacters(from: sp, into: &b)
        scanner.scanUpToCharacters(from: sp, into: &a)
        let defaultColor = UIColor.lightGray
        guard let rRed = r else {return defaultColor}
        guard let rGreen = g else {return defaultColor}
        guard let rBleu = b else {return defaultColor}
        guard let rAlpha = a else {return defaultColor}
        let rFloat = CGFloat(rRed.doubleValue)
        let gFloat = CGFloat(rGreen.doubleValue)
        let bFloat = CGFloat(rBleu.doubleValue)
        let aFloat = CGFloat(rAlpha.doubleValue)
        return UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
    }
}
