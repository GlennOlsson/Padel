//
//  Court.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct Court: View {
    var body: some View {
		HStack {
			VStack {
				NameTag(name: "Lindblad")
				NameTag(name: "Rabun")
			}

			listRowSeparator(.visible)

			VStack {
				NameTag(name: "Treutiger")
				NameTag(name: "Olsson")
			}
		}
		.background(Color.white)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 1)
		)
    }
}

struct NameTag: View {
	let name: String

	var body: some View {
		HStack {
			Text(name)
				.padding(10)
		}
		.background(Color.white)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 1)
		)
	}
}

struct Court_Previews: PreviewProvider {
    static var previews: some View {
        Court()
    }
}
