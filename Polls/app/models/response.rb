# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true

  belongs_to(
    :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'
  )

  belongs_to(
    :answer_choice,
    foreign_key: :answer_id,
    primary_key: :id,
    class_name: 'AnswerChoice'
  )

  has_one :question, through: :answer_choice , source: :question

  def sibling_responses
    question.responses
    .where(':id IS NULL OR responses.id != :id', id: id)
  end

  private
    def respondent_has_not_already_answered_question

    end
end
