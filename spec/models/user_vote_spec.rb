require 'spec_helper'

describe UserVote do
  it { should belong_to(:user) }
  it { should belong_to(:link) }
end