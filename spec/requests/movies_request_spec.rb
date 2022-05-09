require 'rails_helper'

RSpec.describe "moviesコントローラーのテスト", type: :request do
  describe 'ログイン済み' do
    before do
      @user = create(:user)
      sign_in @user
    end
    context "動画一覧ページが正しく表示される" do
      let!(:movies) { create_list(:movie, 11, user: @user) }
      before do
        get movies_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it '10件動画が返却されること' do
        expect(JSON.parse(response.body).length).to eq 10
      end
      it '1responseが作成日時の新しい順にならんでいること' do
        expect(JSON.parse(response.body)[0]["id"]).to eq movies.last.id
      end
    end
  end
end