//
//  BackgroundCardComponent.swift
//  Biern
//
//  Created by Kenrick Dietrich on 24/09/2020.
//  Copyright © 2020 AAD_Group_4. All rights reserved.
//

import SwiftUI

struct BackgroundCardComponent: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
        Color("Grey")
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                ZStack {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .position(x: screenWidth * 0.5, y: screenHeight * 0.55)
                    ZStack {
                        Rectangle()
                            .fill(Color("White"))
                            .frame(width: screenWidth * 0.8, height: screenHeight * 0.75)
                            .cornerRadius(28)
                        ZStack {
                        Circle()
                            .fill(Color("White"))
                            .frame(width: screenWidth * 0.5,
                                   height: screenHeight * 0.5)
                        Image("crown")
                            .resizable()
                            .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)

                        }.position(x: screenWidth * 0.5, y: screenHeight * 0.06)

                    }
                    .position(x: screenWidth * 0.5, y: screenHeight * 0.38)
                }
            )
    }
}

struct BackgroundCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCardComponent()
    }
}
