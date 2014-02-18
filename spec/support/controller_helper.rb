# -*- coding: utf-8 -*-
shared_examples '認証が必要なページ' do
  it 'トップページにリダイレクトすること' do
    expect(response).to redirect_to(root_path)
  end
end
