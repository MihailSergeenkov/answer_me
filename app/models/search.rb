class Search < ActiveRecord::Base
  SEARCH_CONDITIONS = %w(Questions Answers Comments Users Anything)

  def self.query(query, condition)
    if condition == 'Anything'
      ThinkingSphinx.search query
    else
      ThinkingSphinx.search query, classes: [condition.singularize.classify.constantize]
    end
  end
end
