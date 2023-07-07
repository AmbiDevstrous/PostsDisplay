//
//  ContentView.swift
//  PostDisplayerWithComments
//
//  Created by Macbook on 7/07/23.
//

import SwiftUI

struct ContentView: View {
    private(set) var posts: [Post]?

  //  @StateObject PostConfig
    var body: some View {
        var service = GetPostsService()
        NavigationView {
            Button("Fetch Posts") {
                service.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
