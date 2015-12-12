class HomeController < ApplicationController
	def index
		render text: ''
	end

	def api
		render layout: false
	end
end
