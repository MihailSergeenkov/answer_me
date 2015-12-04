module AnswersHelper
  def best_answer(answer)
    answer.best ?
    { tag: 'div', class: 'panel panel-default row best-answer', id: "answer-#{answer.id}" } :
    { tag: 'div', class: 'panel panel-default row', id: "answer-#{answer.id}" }
  end
end
