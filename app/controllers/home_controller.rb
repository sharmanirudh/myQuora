class HomeController < ActionController::Base

	def index
	end

	def question
		puts "=======================================#{params}"
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
end