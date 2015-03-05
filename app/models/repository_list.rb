class RepositoryList
  attr_reader :repositories

#  def initialize(username)
#    results = HTTParty.get(
#        "https://api.github.com/users/#{username}/repos?sort=updated",
#        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
#                     "User-Agent" => "anyone"
#                    }
#    )
#    @repositories = results.map {|r| Repository.new(r)}
#  end
  def initialize(username)
    Rails.cache.fetch("#{cache_key}/users", :expires_in => 2.hours) do
      results = HTTParty.get(
      "https://api.github.com/users/#{username}/repos?sort=updated",
      :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
      "User-Agent" => "anyone"
                  }
    )
    @repositories = results.map {|r| Repository.new(r)}

    end
  end

end
