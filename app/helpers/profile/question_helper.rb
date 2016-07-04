module Profile::QuestionHelper

  def question_avatar(q)
    return user_avatar_small(q.adviser) unless q.adviser.blank?
    image_tag("/assets/icons/unassigned.gif", alt: "Not assigned")
  end

end