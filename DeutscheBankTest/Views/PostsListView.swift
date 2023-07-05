//
//  PostsListView.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 04/07/23.
//

import SwiftUI

enum FavSection : String, CaseIterable {
    case all = "All"
    case fav = "FAV"
}

struct PostsListView: View {
    @StateObject var vm = PostListViewModel()
    @State var segmentationSelection : FavSection = .all
    var userId : String?
    
    var body: some View {
        if !vm.errorMessage.isEmpty {
            ErrorView(vm: vm)
        } else {
            VStack {
                Picker("", selection: $segmentationSelection) {
                    ForEach(FavSection.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(8)
                List {
                    ForEach(vm.filteredItems) { post in
                        NavigationLink {
                            CommentsView(vmPost: vm, post: post)
                        } label: {
                            PostRowView(vm: vm, post: post)
                        }
                    }
                }
            }
            .overlay(content: {
                if vm.isLoading {
                    ProgressView()
                }
            })
            .navigationTitle("My Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .task {
                vm.userId = userId
                await vm.getPosts()
            }
            .onChange(of: segmentationSelection) { newValue in
                vm.sortFavs()
            }
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        PostsListView(userId: "1")
    }
}
