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
            viewModel.state.router(viewModel.state.tree)
        }
        .listStyle(SidebarListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
