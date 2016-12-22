class StandardPropsMatcher


def self.match_key(key)
  @key = key
  match_first_name
  match_email
  match_last_name
  match_username
end

  def self.match_first_name
  first_name_reg =/^first_name$|^First\ Name$|^firstname$/i
  @key.match(first_name_reg) ? @key = 'first_name' : @key
  end

  def self.match_email
  email_reg =/^emailaddress$|^email\ address$|^email_address$|email/i
  @key.match(email_reg) ? @key = 'email' : @key
  end

  def self.match_last_name
  last_name_reg =/^last_name$|^Last\ Name$|^LastName$/i
  @key.match(last_name_reg) ? @key = 'last_name' : @key
  end

  def self.match_username
  username_reg =/^username$|^user_name$|^UserName$/i
  @key.match(username_reg) ? @key = 'username' : @key
  end


end
