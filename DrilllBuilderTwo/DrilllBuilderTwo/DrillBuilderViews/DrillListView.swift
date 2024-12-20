//
//  DrillListView.swift
//  DrilllBuilderTwo
//
//  Created by Saqib Fareedi on 12/18/24.
//

import SwiftUI
struct DrillListView: View {
    var savedDrills: [Drill] // Non-binding array of drills
    var loadDrill: (Drill) -> Void

    var body: some View {
        VStack {
            Text("Saved Drills")
                .font(.headline)
                .padding()

            List {
                ForEach(savedDrills, id: \.name) { drill in
                    HStack {
                        Text(drill.name)
                        Spacer()
                        Button("Load") {
                            loadDrill(drill)
                        }
                    }
                }
            }

            Button("Close") {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
