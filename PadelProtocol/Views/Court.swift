//
//  Court.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct Court: View {

	let court_width: CGFloat = 500;
	let court_height: CGFloat = 500 * 0.5;

    var body: some View {
		HStack {
			HStack {
				VStack {
					NameTag(name: "Lindblad")

					Spacer()

					NameTag(name: "Rabun")
				}.padding()
				Spacer()
			}.frame(width: self.court_width/2)

			Rectangle()
			//For some reason expands beyond frame when = court_height
				.frame(width: 1, height: court_height * 0.99)
				.background(Color.black)


			HStack {
				Spacer()
				VStack {
					NameTag(name: "Olsson")

					Spacer()

					NameTag(name: "Treutiger", is_serving: true)
				}.padding()
			}.frame(width: self.court_width/2)
		}
		.frame(height: court_height)
		.background(Color.white)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 1)
		)
    }
}

struct NameTag: View {
	let name: String
	let is_serving: Bool

	init(name: String, is_serving: Bool = false) {
		self.name = name
		self.is_serving = is_serving
	}

	var body: some View {
		HStack {
			if is_serving {
				Text("🎾")
			}
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
}

struct Court_Previews: PreviewProvider {
    static var previews: some View {
        Court()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
