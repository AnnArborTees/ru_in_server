require 'rails_helper'

describe Users::RegistrationsController do
  let(:result) { JSON.parse(response.body).with_indifferent_access }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'given an email, password, and password_confirmation (> 8 characters)' do
      it 'creates a user and returns its json representation' do
        post :create, format: :json, user: {
          email: 'test@example.com', password: 'pw4tester22', password_confirmation: 'pw4tester22'
        }
        expect(response).to be_ok

        expect(result[:email]).to eq 'test@example.com'
        expect(result[:authentication_token]).to_not be_nil
        expect(User.where(email: 'test@example.com')).to exist
      end
    end

    context 'given an email, password, and mismatched password_confirmation' do
      it 'does not create a user and returns the errors as json' do
        post :create, format: :json, user: {
          email: 'test@example.com', password: 'pw4tester22', password_confirmation: 'woopsmyhandsslipped'
        }
        expect(response.status).to eq 422

        expect(result[:errors][:password_confirmation]).to include "doesn't match Password"
      end
    end
  end
end
