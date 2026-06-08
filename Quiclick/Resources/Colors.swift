//
//  Colos.swift
//  a-via
//
//  Created by Soraia Freire Batista on 08/06/26.
//
import SwiftUI

extension UIColor {
    class var cardBackgoundColor: UIColor{
        guard let color = UIColor(named:"CarbonCards") else {return .white}
        return color
    }
    class var buttonsColor: UIColor{
        guard let color = UIColor(named:"LimeButtons") else {return .white}
        return color
    }
}
