module main

import vweb
import os

struct App {
	vweb.Context
}

struct Recipe {
	path  string
	title string
	date  string
}

const recipes = {
	'kylling-taco-grønnsaker': Recipe{'kylling-taco-grønnsaker', 'Kylling med tacokrydder og grønnsaker', '12/10/21'}
}

fn main() {
	mut app := &App{}
	app.handle_static('assets', true)
	vweb.run(app, 8000)
}

['/']
pub fn (mut app App) index() vweb.Result {
	return $vweb.html()
}

['/:recipe]']
pub fn (mut app App) recipe(recipe string) vweb.Result {
	file := "articles/" + recipes[recipe].path + ".html"
	body := os.read_file(file) or { return app.text('Recipe not found') }
	return app.html(body)
}
