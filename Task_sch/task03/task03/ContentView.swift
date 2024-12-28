//
//  ContentView.swift
//  task03
//
//  Created by deathot on 11/17/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LocationSearchViewModel()
    
    var body: some View {
        ZStack {
            MapView(annotations: viewModel.annotations)
            VStack(alignment: .leading) {
                Text("221409040425 肖国豪")
                    .bold()
                    .font(.title2)
                    .italic()
                    .padding(.top, 490)
                    .padding(.leading, 10)

                Spacer()
                
                VStack {
                    SearchBar(searchText: $viewModel.searchQuery, onCommit: {
                        viewModel.performSearch()
                    })
                    
                    List(viewModel.searchResults, id: \.self) { result in
                        Button {
                            viewModel.selectPlace(result)
                        } label: {
                            HStack {
                                Text(result.name ?? "Unknown Place")
                                    .font(.body)
                                Spacer()
                                Image(systemName: "location.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 2 / 5)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -2)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
