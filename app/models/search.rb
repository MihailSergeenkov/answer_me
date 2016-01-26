class Search
  SEARCH_CONDITIONS = %w(Questions Answers Comments Users Anything)

  def self.query(query, condition)
    if SEARCH_CONDITIONS.include?(condition)
      if condition == 'Anything'
        ThinkingSphinx.search query
      else
        ThinkingSphinx.search query, classes: [condition.singularize.classify.constantize]
      end
    else
      []
    end
  end
end
