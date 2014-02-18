# -*- coding: utf-8 -*-
require 'spec_helper'

describe ApplicationHelper do
  describe '#url_for_twitter' do
    it '引数とした渡したユーザの twitter URLを返すこと' do
      user = create :user, nickname: 'willnet'

      expect(helper.url_for_twitter(user)).to eq 'https://twitter.com/willnet'
    end
  end
end
