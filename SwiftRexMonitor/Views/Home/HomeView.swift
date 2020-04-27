//
//  HomeView.swift
//  SwiftRexMonitor
//
//  Created by Luiz Rodrigo Martins Barbosa on 27.04.20.
//  Copyright © 2020 DeveloperCity. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomePresenter.ViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.state.title)

                List {
                    ForEach(self.viewModel.state.connectedApps) { app in
                        VStack {
                            Text(app.name)

                            TextField("State", text: .constant(app.state))
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .mock(state: .empty))
    }
}

#endif
