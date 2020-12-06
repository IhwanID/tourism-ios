//
//  ProfileView.swift
//  tourism
//
//  Created by Ihwan ID on 06/12/20.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Form{
            HStack{
                Image("profile")
                    .resizable()
                    .frame(width: 120, height: 120)                .aspectRatio(contentMode: .fill).clipShape(Circle())
                    .shadow(radius: 10)
                    .padding()
                Text("Ihwan Dede")
                    .font(.title)
            }

            Section{
                Label("ihwan.id@icloud.com", systemImage: "envelope")
                Label("https://ihwan.id", systemImage: "globe")
            }
        }
        .navigationTitle("Profile")

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
