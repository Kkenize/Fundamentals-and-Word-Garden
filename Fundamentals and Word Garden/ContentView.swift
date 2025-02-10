//
//  ContentView.swift
//  Fundamentals Two
//
//  Created by Zhejun Zhang on 2/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var messageString = ""
    
    var body: some View {
        GeometryReader { geometry in
            //        This is for setting background colors
            //        ZStack {
            //            Color.skyBlue
            //                .ignoresSafeArea(edges: .all)
            
            VStack {
                Text("You have skills!")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                    .padding()
//                    .frame(width: .infinity)
                    .background(.skyBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                
                Spacer()
                
                Text(messageString)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.red)
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                    .padding()
                //                .frame(width: 300, height: 150)
                //                    .border(.orange, width: 2)
                
                Spacer()
                Spacer()
                Spacer()
                
                Divider()
                    .background(.gray)
                    .frame(width: geometry.size.width, height: 1)
                
                
                HStack {
                    Button("Awesome") {
                        messageString = "You are awesome!"
                    }
                    
                    Spacer()
                    
                    Button("Great") {
                        messageString = "You are great!"
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
// Sets the bottom safe area to skyBlue
                Rectangle()
                    .frame(height: 0)
                    .background(.skyBlue)
                
            }
            .padding()
            .background(Gradient(colors: [.skyBlue, .green]))
            //        }
        }
    }
}

#Preview {
    ContentView()
}
