require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'account_activation' do
    let(:user) { create(:user) }
    let(:inviter) { create(:user) }
    let(:mail) { UserMailer.account_activation(user, inviter) }
    before { user.activation_token = User.new_token }

    it 'renders the headers' do
      expect(mail.subject).to eq('【LiveLog】アカウントの有効化')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@livelog.ku-unplugged.net'])
    end

    xit 'renders the body' do # TODO: Solve encoding of Japanese mail
      expect(mail.body.encoded).to match(user.full_name)
      expect(mail.body.encoded).to match(user.activation_token)
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

  describe 'password_reset' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.password_reset(user) }
    before { user.reset_token = User.new_token }

    it 'renders the headers' do
      expect(mail.subject).to eq('【LiveLog】パスワード再設定')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@livelog.ku-unplugged.net'])
    end

    xit 'renders the body' do # TODO: Solve encoding of Japanese mail
      expect(mail.body.encoded).to match(user.reset_token)
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

end
