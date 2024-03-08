//
//  Extension.swift
//  Netflix Clone
//
//  Created by İsmail Parlak on 8.03.2024.
//

import Foundation

extension String {
    func capitializeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

