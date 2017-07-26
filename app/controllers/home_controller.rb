class HomeController < ApplicationController

	def index
	end

	def question
		if(params["content"] != "")
			@question = Question.new
			@question.content = params["content"]
			@question.user_id = current_user.id
			if @question.save
				respond_to do |format|
					format.js {    }
				end
			else

			end
		end
	end
	def answer
		if(params["content"] != "")
			@answer = Answer.new
			@answer.content = params["content"]
			@answer.user_id = current_user.id
			@question_id = params["question_id"]
			@answer.question_id = @question_id
			if @answer.save
				respond_to do |format|
					format.js {    }
				end
			else

			end
		end
	end
	def up_vote
		@type_id = params["upvotetype_id"]
		@type = params["type"]
		if(earlier_downvote = Downvote.where(downvotetype_id: @type_id, downvote_type: @type, user_id: current_user).first)
			earlier_downvote.destroy
			respond_to do |format|
				format.js {  render "down_vote.js.erb"  }#if already existing down vote is there then update its count
			end
		else
			if( !Upvote.where(upvotetype_id: @type_id, upvote_type: @type, user_id: current_user).first )
				upvote = Upvote.new
				upvote.upvotetype_id = @type_id
				upvote.upvote_type = @type
				upvote.user_id = current_user.id
				if upvote.save
					respond_to do |format|
						format.js {    }
					end
				else

				end
			end
		end
	end
	def down_vote
		@type_id = params["downvotetype_id"]
		@type = params["type"]
		if(earlier_upvote = Upvote.where(upvotetype_id: @type_id, upvote_type: @type, user_id: current_user).first)
			earlier_upvote.destroy
			respond_to do |format|
				format.js {  render "up_vote.js.erb"  }# if already existing up vote is there then update its count
			end
		else
			if( !Downvote.where(downvotetype_id: @type_id, downvote_type: @type, user_id: current_user).first )
				downvote = Downvote.new
				downvote.downvotetype_id = @type_id
				downvote.downvote_type = @type
				downvote.user_id = current_user.id
				if downvote.save
					respond_to do |format|
						format.js {    }
					end
				else

				end
			end
		end
	end

	def edit
		answer_id = params["answer_id"]
		@answer = Answer.where(id: answer_id).first
		if @answer
			respond_to do |format|
				format.js {    }
			end
		else

		end
	end

	def update_answer
		sanswer_id = params["answer_id"]
		content = params["content"]
		@answer = Answer.where(id: answer_id).first
		@answer.content = content
		if @answer.save
			respond_to do |format|
				format.js {    } 
			end
		else

		end
	end

	def delete
		@type_id = params["deletetype_id"]
		@type = params["type"]
		if(@type == 'A')
			answer = Answer.where(id: @type_id, user_id: current_user).first
			if answer.destroy
				upvotes = Upvote.where(upvotetype_id: answer.id, upvote_type: 'A')
				downvotes = Downvote.where(downvotetype_id: answer.id, downvote_type: 'A')
				upvotes.each do |upvote|
					upvote.destroy
				end
				downvotes.each do |downvote|
					downvote.destroy
				end
				respond_to do |format|
					format.js {    }
				end
			end
		end
	end
end