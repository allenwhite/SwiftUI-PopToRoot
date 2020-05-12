//
//  ContentView.swift
//  PopToRootExample
//
//  Created by Allen White on 5/12/20.
//  Copyright © 2020 Allen White. All rights reserved.
//

import SwiftUI


class RoutingBrain: ObservableObject {
    static let instance = RoutingBrain()
    
    @Published var show2: Bool = false
    @Published var show3: Bool = false
    
    func popToRoot() {
        self.show3 = false
        self.show2 = false
    }
}

struct ContentView: View {
    @EnvironmentObject var brain: RoutingBrain
    
    var body: some View {
        NavigationView {
            VStack {
                Text("funky chiken")
                NavigationLink(destination: ContentView2(), isActive: self.$brain.show2) { EmptyView()}
                .isDetailLink(false)
            }
            .navigationBarTitle("Root")
            .navigationBarItems(trailing:
                Button(action: { self.brain.show2 = true }, label: {
                    Text("Go to two")
                })
            )
        }
    }
}

struct ContentView2: View {
    @EnvironmentObject var brain: RoutingBrain
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Button(action: { self.brain.show3 = true }) {
                Text("Go to three")
            }
            .navigationBarTitle("Two")
            
            NavigationLink(destination: ContentView3(), isActive: self.$brain.show3) { EmptyView() }
            .isDetailLink(false)
        }
    }
}

struct ContentView3: View {
    @EnvironmentObject var brain: RoutingBrain
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Button (action: {
                self.brain.popToRoot()
            } ){
                Text("Pop to root")
            }
        }.navigationBarTitle("Three")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RoutingBrain.instance)
    }
}
