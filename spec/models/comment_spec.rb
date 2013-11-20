require 'spec_helper'

describe Comment do
  it { should belong_to(:user) }
  it { should belong_to(:link) }
  it { should have_many(:child_comments) }
end
