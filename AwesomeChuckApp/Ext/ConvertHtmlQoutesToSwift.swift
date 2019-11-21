//
//  ConvertHtmlQoutesToSwift.swift
//  AwesomeChuckApp
//
//  Created by Denis Rakitin on 2019-05-30.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import Foundation


//Расширение класса String, реализующее возможность преобразования специальных знаков HTML в человекочетаемый формат
extension String{
    
    func convertSpecialCharacters() -> String {
        var newString = self
        let char_dictionary = [
            "&amp;" : "&",
            "&lt;" : "<",
            "&gt;" : ">",
            "&quot;" : "\"",
            "&apos;" : "'"
        ];
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: NSString.CompareOptions.literal, range: nil)
        }
        return newString
    }
}
