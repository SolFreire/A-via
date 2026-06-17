//
//  TemplateThumbnail.swift
//  a-via
//
//  Created by Luiz Henrique da Silva Bezerra on 11/06/26.
//

import SwiftUI

struct TemplateThumbnail: View{
    
    let imageTemplate = "Distance42kmImage"
    
    var body: some View{
        Image(imageTemplate)
    }
}

#Preview {
    TemplateThumbnail()
}
