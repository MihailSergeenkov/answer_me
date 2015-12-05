module AnswersHelper
  def best_answer(answer)
    { tag: 'div', class: "panel panel-default row #{answer.best? ? 'best-answer' : ''}", id: "answer-#{answer.id}" }
  end
end
