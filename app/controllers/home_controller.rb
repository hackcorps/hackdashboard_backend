class HomeController < ApplicationController
	def index
		render text: 'Hello guys'
	end

	def api
		render layout: false
	end
end
