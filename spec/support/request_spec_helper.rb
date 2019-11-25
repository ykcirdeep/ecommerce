module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def serializer_helper(data)
    JSON.parse(Oj.dump(data, mode: :compat))
  end
end
