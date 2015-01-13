class NationTagger
  @queue = :nation_tagger

  def self.perform(user_id, status)
    user_email = User.find(user_id).email
    NbService.account_tag(user_email, status)
  end
end
