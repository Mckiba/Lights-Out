//
//  MovieView.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/17/22.
//

import SwiftUI

struct MovieView: View {
    let movie : Movie
    var body: some View {
        Text(movie.name!)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie.example())
    }
}
