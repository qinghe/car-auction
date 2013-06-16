module UsersHelper
	
	def escape_user(user)
Rails.logger.debug "user=#{user.inspect}"	  
		image_tag("flags/#{user.country.downcase}.gif") +" "+ user.login
	end
	
end