//
//  TestLibrary.swift
//  ReadTogether
//
//  Created by Александр on 09.03.2021.
//

import SwiftUI
import Combine

struct TestLibrary: View {
    
  @ObservedObject private var viewModel = BooksViewModel()
  @State private var presentAddNewBookScreen = false
    
  var body: some View {

    GeometryReader { geometry in
        NavigationView {
            List {
                ForEach (viewModel.books) { book in
                    BookRow(book: book)
            }
        }
            .navigationBarTitle("Books")
            .toolbar {
                ToolbarItem {
                    Button(action: { presentAddNewBookScreen.toggle() },
                           label: { Image(systemName: "plus") })
                }
            }
            .sheet(isPresented: $presentAddNewBookScreen, content: { BookEditView() })
            .onAppear() {
            self.viewModel.fetchData()
            }
        }
    }
  }
    private func BookRow(book: Book) -> some View {
        NavigationLink(destination: BookView()) {
          VStack(alignment: .leading) {
            Text(book.title)
              .font(.headline)
            Text(book.author)
              .font(.subheadline)
            Text("\(book.numberOfPages) pages")
              .font(.subheadline)
          }
        }
      }
    // func needed to make every single element from th books array, makes it possible to navigate to every element

}

struct TestLibrary_Previews: PreviewProvider {
    static var previews: some View {
        TestLibrary()
    }
}
