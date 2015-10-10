module ControllerMacros
	def response_as_json
		ActiveSupport::JSON.decode(response.body).with_indifferent_access
	end
end
