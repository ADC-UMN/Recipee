//
//  Recipe+Image.swift
//  Recipee
//
//  Created by Khan Winter on 9/28/21.
//

import Foundation
import UIKit

extension Recipe {
    
    var image: UIImage? {
        get {
            let fm = FileManager.default
            let baseURL = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let imageURL = baseURL.appendingPathComponent("\(id ?? "BRUH").png")
            
            if id == "recipe1" || id == "recipe2" || id == "recipe3" || id == "recipe0" {
                return UIImage(named: id!)
            }
            
            return UIImage(contentsOfFile: imageURL.path)
        }
        set {
            if let data = newValue?.pngData() {
                let fm = FileManager.default
                let baseURL = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let imageURL = baseURL.appendingPathComponent("\(id ?? "BRUH").png")
                
                do {
                    try data.write(to: imageURL)
                } catch {
                    print(error)
                }
            }
        }
    }
    
}
