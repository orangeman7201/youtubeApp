require 'rails_helper'

RSpec.describe "postsコントローラーのテスト", type: :request do
  describe 'ログイン済み' do
    let!(:post) { FactoryBot.create(:post) }
    before do
      @user = post.user
      sign_in @user
    end
    context "投稿一覧ページが取得できる" do
      let!(:posts) { create_list(:post, 3, user: @user) }
      before do
        get posts_path
      end
      it 'リクエストは200 OKとなること' do
        debugger
        expect(response.status).to eq 200
      end
      it '3件postが返却されること' do
        expect(response.body.length).to eq 3
      end
    end
  end
end