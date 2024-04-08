//
//  InfoView.swift
//  Joker APp
//
//  Created by Anton on 2/4/24.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presMode
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presMode.wrappedValue.dismiss()
                } label: {
                    Image("ic_home")
                }
                
                VStack {
                    Spacer().frame(height: 42)
                    Text("Info")
                        .font(.custom(FontName.lilitOne, size: 52))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 0, y: 2)
                        .shadow(color: .white, radius: 4, x: 0, y: 4)
                }
                
                Spacer()
            }
            .padding()
            
            Image("info_game")
                .resizable()
                .frame(width: 380, height: 270)
        }
        .background(
            Image("game_app_back")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    InfoView()
}
