require 'spec_helper'

describe Ticket do
  it { should belong_to(:user) }
  it { should belong_to(:event) }

  it { should ensure_length_of(:comment).is_at_most(30) }
  it { should allow_value('', nil).for(:comment) }
end
