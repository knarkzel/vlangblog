module main

import vweb
import os

struct App {
	vweb.Context
}

fn main() {
	mut app := &App{}
	app.handle_static('assets', true)
	vweb.run(app, 8000)
}

['/']
pub fn (mut app App) index() vweb.Result {
	mut articles := []string{}
	articles = os.ls('articles/') or { return app.text("Articles doesn't exist") }
	return $vweb.html()
}

['/:article]']
pub fn (mut app App) article(article string) vweb.Result {
	file := 'articles/' + article
	body := os.read_file(file) or { return app.text('Article not found') }
	return app.html(body)
}
