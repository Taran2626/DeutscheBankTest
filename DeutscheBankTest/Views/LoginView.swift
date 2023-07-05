//
//  LoginView.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 04/07/23.
//

import SwiftUI

struct LoginView: View {
    @State var userId: String = ""
    
    var isLoginInButtonDisabled: Bool {
        [userId].contains(where: \.isEmpty)
    }
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                TextField("User ID",
                          text: $userId,
                          prompt: Text("User ID").foregroundColor(.blue))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: PostsListView(userId: userId), tag: 1, selection: $selection) {
                    Button {
                        selection = 1
                    } label: {
                        Text("Login")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: isLoginInButtonDisabled ? [.gray] : [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(20)
                    .disabled(isLoginInButtonDisabled)
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
