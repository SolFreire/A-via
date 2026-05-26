//
//  SwiftUIView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 26/05/26.
//

import SwiftUI

struct SwiftUIView: View {
    // Initialise to a size proportional to the screen dimensions.
        @State private var width = UIScreen.main.bounds.size.width / 3.5
        @State private var height = UIScreen.main.bounds.size.height / 1.5
        
        var body: some View {
            VStack { // <-- Wrapping VStack with alignment modifier
                // This is the view that's going to be resized.
                ZStack(alignment: .bottomTrailing) {
                    Text("Hello, world!")
                        .frame(width: width, height: height)
                    // This is the "drag handle" positioned on the lower-left corner of this stack.
                    Text("")
                        .frame(width: 30, height: 30)
                        .background(.red)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Enforce minimum dimensions.
                                    width = max(100, width + value.translation.width)
                                    height = max(100, height + value.translation.height)
                                }
                        )
                }
                .frame(width: width, height: height, alignment: .topLeading)
                .border(.red, width: 5)
                .background(.yellow)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
}

#Preview {
    SwiftUIView()
}
