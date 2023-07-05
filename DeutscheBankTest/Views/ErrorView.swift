//
//  ErrorView.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 05/07/23.
//

import SwiftUI

struct ErrorView: View {
    @StateObject var vm: PostListViewModel

    var body: some View {
        Text(vm.errorMessage)
        Button {
            Task {
                await vm.getPosts()
            }
        } label: {
            Text("Try Again")
        }
    }

}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(vm: PostListViewModel())
    }
}
