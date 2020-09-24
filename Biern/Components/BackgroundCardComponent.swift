//
//  BackgroundCardComponent.swift
//  Biern
//
//  Created by Kenrick Dietrich on 24/09/2020.
//  Copyright © 2020 AAD_Group_4. All rights reserved.
//

import SwiftUI

struct BackgroundCardComponent: View {
    var body: some View {
        Color("Grey")
            .edgesIgnoringSafeArea(.vertical) // Ignore just for the color
            .overlay(
                GeometryReader { metrics in
                    ZStack {
                        Image("background")
                            .resizable()
                            .scaledToFill()
                            .position(x: metrics.size.width * 0.5, y: metrics.size.height * 0.55)
                        ZStack {
                            Rectangle()
                                .fill(Color("White"))
                                .frame(width: metrics.size.width * 0.8, height: metrics.size.height * 0.7)
                                .cornerRadius(28)
                            ZStack {
                                Circle()
                                    .fill(Color("White"))
                                    .frame(width: metrics.size.width * 0.5,
                                           height: metrics.size.height * 0.5)
                                    .position(x: metrics.size.width * 0.5, y: 115)
                                Image("crown")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .position(x: metrics.size.width * 0.5, y: 104)

                            }
                        }
                        .position(x: metrics.size.width * 0.5, y: metrics.size.height * 0.58)
                    }
            })
    }
}
