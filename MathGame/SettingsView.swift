//
//  SettingsView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-20.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var fontSize: Double
    @State var isEditing: Bool = false
    @State var pickerValue: Int = 0
    @Binding var selectedColor: Color
    
    var body: some View {
        // Settings content
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Font size (\(fontSize)px)")
                
                Slider(value: $fontSize, in: 14...30, onEditingChanged: { editing in
                                isEditing = editing
                    fontSize = fontSize.rounded()
                })
                .tint(Color("Emerald"))
                
                HStack {
                    Text("System Color")
                    Picker("", selection: $pickerValue, content: {
                        Text("Sapphire").tag(0)
                        Text("Ruby").tag(1)
                        Text("Emerald").tag(2)
                    })
                    .pickerStyle(.wheel)
                    .onChange(of: pickerValue, perform: { newValue in
                        switch newValue {
                        case 0:
                            selectedColor = Color("Sapphire")
                        case 1:
                            selectedColor = Color("Ruby")
                        case 2:
                            selectedColor = Color("Emerald")
                        default:
                            selectedColor = Color("Sapphire")
                        }
                    })
                    
                    Rectangle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(selectedColor)
                }
            }
            .padding()
            .navigationTitle("Settings")
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(fontSize: .constant(14.0), selectedColor: .constant(Color("Sapphire")))
    }
}
