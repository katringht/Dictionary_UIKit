//
//  main.swift
//  1exes
//
//  Created by Ekaterina Tarasova on 01.03.2021.
//

import Foundation

var inputNum = readLine()
//private let minNumLenght = 11
//private var regex = "^\\+?\\d{1}[ (]+?\\d{3}[) ]+?\\d{3}-?\\d{2}-?\\d{2}$"
private var regex = "^\\+?\\d{1}[ ]?[ (]?\\d{3}[) ]?[ ]?\\d{3}-?[ ]?\\d{2}-?\\d{2}$"
func format(num: String) -> Bool {
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", regex)
    let result = phoneTest.evaluate(with: num)
    return result
}

private func formatPhoneNumber(number: String) -> String {

    var result = ""
    let mask = "8 (XXX) XXX-XX-XX"

    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let substring = cleanPhoneNumber.dropFirst()
    var index = substring.startIndex

        if format(num: "\(inputNum!)") != false{
            for ch in mask where index < cleanPhoneNumber.endIndex {
                if ch == "X" {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(ch)
                }
            }
        }else{print("error")}


    return result
}

print(formatPhoneNumber(number: "\(inputNum!)"))
//print(format(num: "\(String(describing: inputNum))"))
