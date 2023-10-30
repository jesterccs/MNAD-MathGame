//
//  MainTabView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-20.
//

import SwiftUI

struct MainTabView: View {
    
    @State var fontSize: Double = 14.0
    @State var selectedColor: Color = Color("Sapphire")
    
    var body: some View {
        // TabView content
        TabView {
            GameView(fontSize: $fontSize, selectedColor: $selectedColor)
                .tabItem { Label("Home", systemImage: "checkmark.circle.badge.questionmark.fill") }
            
            SettingsView(fontSize: $fontSize, selectedColor: $selectedColor)
                .tabItem { Label("Setting", systemImage: "gear.circle.fill") }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
