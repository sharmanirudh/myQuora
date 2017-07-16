class HomeController < ActionController::Base

	def index
	end

	def question
		if(params["content"] != "")
			question = Question.new
			question.content = params["content"]
			question.user_id = current_user.id
			question.save
		end
		return redirect_to '/'
	end
	def answer
		if(params["content"] != "")
			answer = Answer.new
			answer.content = params["content"]
			answer.user_id = current_user.id
			answer.question_id = params["question_id"]
			answer.save
		end
		return redirect_to '/'
	end
	def up_vote
		upvotetype_id = params["upvotetype_id"]
		upvote_type = params["type"]
		if( !Upvote.where(upvotetype_id: upvotetype_id, upvote_type: upvote_type, user_id: current_user).first )
			upvote = Upvote.new
			upvote.upvotetype_id = upvotetype_id
			upvote.upvote_type = upvote_type
			upvote.user_id = current_user.id
			upvote.save
		end
		return redirect_to '/'
	end
	def down_vote
		downvotetype_id = params["downvotetype_id"]
		downvote_type = params["type"]
		if( !Downvote.where(downvotetype_id: downvotetype_id, downvote_type: downvote_type, user_id: current_user).first )
			downvote = Downvote.new
			downvote.downvotetype_id = downvotetype_id
			downvote.downvote_type = downvote_type
			downvote.user_id = current_user.id
			downvote.save
		end
		return redirect_to '/'
	end
end