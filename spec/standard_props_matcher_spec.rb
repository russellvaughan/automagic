describe StandardPropsMatcher do

  let(:standard_props_matcher) { StandardPropsMatcher }

  describe "#self.match key" do

  it "returns 'first_name' when matches regex of 'first name' " do
    expect(standard_props_matcher.match_key('first name')).to eq('first_name')
  end

  it "returns itself when does not match regex of 'first_name" do
    expect(standard_props_matcher.match_key('name')).to eq('name')
  end

   it "returns itself when substring includes first" do
    expect(standard_props_matcher.match_key('firstnamessss')).to eq('firstnamessss')
  end

    it "returns 'last_name' when matches regex of 'last name' " do
    expect(standard_props_matcher.match_key('last name')).to eq('last_name')
  end

  it "returns itself when does not match regex of 'last_name" do
    expect(standard_props_matcher.match_key('last')).to eq('last')
  end

   it "returns itself when substring includes first" do
    expect(standard_props_matcher.match_key('names')).to eq('names')
  end

   it "returns 'email' when matches regex of 'Email Address' " do
    expect(standard_props_matcher.match_key('Email')).to eq('email')
  end

  it "returns itself when does not match regex of 'email" do
    expect(standard_props_matcher.match_key('work email')).to eq('work email')
  end

   it "returns itself when substring includes email address" do
    expect(standard_props_matcher.match_key('Email Addresses')).to eq('Email Addresses')
  end

    it "returns 'username' when matches regex of 'user_name' " do
    expect(standard_props_matcher.match_key('user_name')).to eq('username')
  end

  it "returns itself when does not match regex of 'username" do
    expect(standard_props_matcher.match_key('User Name')).to eq('username')
  end

   it "returns itself when substring includes username" do
    expect(standard_props_matcher.match_key('UserNamesssss')).to eq('UserNamesssss')
  end

end

end
