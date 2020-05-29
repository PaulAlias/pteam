//
//  String+Extension.swift
//  TodoApp
//
//  Created by Павел Алешин on 28.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation


//расширение что бы более читабельное стало декодирование %
extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "~!@#$%^&*()-+=[]\\{}<>?/<>,.").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        return encodedString
    }
}
