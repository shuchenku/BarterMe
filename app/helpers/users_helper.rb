module UsersHelper
	def reliability_score(user_id)
		rating_list = Rating.where(:user_id=>user_id)
		count = 0;
		reliability_score = 0;
		rating_list.each do |r|
			if r.score != 0.0
				reliability_score += r.score
				count += 1
			end
		end

		if count != 0
			return reliability_score/count
		else 
			return 0
		end

	end
end
