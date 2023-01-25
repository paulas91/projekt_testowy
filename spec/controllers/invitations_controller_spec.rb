# frozen_string_literal: true

describe InvitationsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe '#accept' do
    let(:friend) { create(:user) }
    let(:invitation) { create(:invitation, invited_id: user.id, invited_by_id: friend.id) }
    let(:params) {{ id: invitation.id }}

    subject(:accept_request) { post :accept, params: params }
    #akceptowanie zaproszenia
    #tworzy się friendship
    #użytkownicy stają się znajomymi

    #jeśli zaproszenie nie należy do użytkownika
    #jeśli zaproszenie nie może zostać zaakceptowane

    it 'accepts the invitation' do
      expect { accept_request}.to change { invitation.reload.state }.from("pending").to("accepted")
    end

    it 'creates friendship for users from invitation' do
      expect { accept_request }.to change(Friendship, :count).by(2)
    end

    it 'users are friends' do
      accept_request
      expect(user.friends).to include friend
      expect(friend.friends).to include user
    end

    context 'when invitation does not belong to user' do
      let(:invitation) { create(:invitation, invited_by_id: friend.id, invited_id: 123123123 )}

      it 'cannot accept this invitation' do
        expect { accept_request}.to raise_error ActiveRecord::RecordNotFound

      end
    end

    context 'when invitation cannot be accepted' do
      before do
        invitation.accept!
      end

      it 'raises error' do
       expect { accept_request }.to raise_error AASM::InvalidTransition
      end
    end
  end

  describe '#reject' do
    subject(:reject_request) { post :reject, params: params}

    let(:friend) { create(:user) }
    let(:invitation) { create(:invitation, invited_id: user.id, invited_by_id: friend.id) }
    let(:params) { { id: invitation.id } }

    # odrzucanie zaproszenia
    #nie tworzy się żadna znajomość

    #jeśli zaproszenie nie należy do usera
    #jeśli zaproszenie nie może zostać odrzucone
    it 'rejects the invitation' do
      expect { reject_request }.to change { invitation.reload.state }.from("pending").to("rejected")
    end

    it 'does not create any friendship' do
      expect { reject_request }.not_to change(Friendship, :count)
    end

    context 'when invitation does not belong to user' do
      let(:invitation) { create(:invitation, invited_by_id: friend.id, invited_id: 123123123) }

      it 'cannot accept this invitation' do
        expect { reject_request }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when invitation cannot be rejected' do
      before do
        invitation.accept!
      end

      it 'raises error' do
        expect { reject_request }.to raise_error AASM::InvalidTransition
      end
    end
  end

  describe '#create' do
    subject(:create_request) { post :create, params: params }

    let(:params) do
      {
        invitation: { email: }
      }
    end

    context 'when user exists' do
      let!(:friend) { create(:user) }
      let(:email) { friend.email }

      it 'creates invitation' do
        expect { create_request }.to change(Invitation, :count).by(1)
      end
    end

    context 'when user does not exist' do
      let(:email) { 'sample.gmail.com' }

      it 'does not create invitation' do
        expect { create_request }.not_to change(Invitation, :count)
      end
    end

    context 'when invitation already sent' do
      let(:friend) { create(:user) }
      let(:email) { friend.email }

      it 'does not create duplicate invitation' do
        Invitation.create!(invited_id: friend.id, invited_by_id: user.id)
        expect { create_request }.not_to change(Invitation, :count)
      end
    end
  end
end

