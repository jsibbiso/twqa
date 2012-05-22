require 'spec_helper'

describe ReportsController do
  let(:admin_auth) {
    @request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(ADMIN_AUTH, LOCAL_PASSWORD)
  }
  let(:user_auth) {
    @request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(APP_AUTH, LOCAL_PASSWORD)
  }

  describe "GET 'index'" do
    it "should return http failure when not enter credential" do
      get 'index'
      response.should_not be_success
    end

    it "should return http failure after entered admin credential" do
      admin_auth
      get 'index'
      response.should_not be_success
    end

    it "returns http success after entered user credential" do
      user_auth
      get 'index'
      response.should be_success
    end

  end

  describe "GET 'players'" do
    it "should return http failure when not enter credential" do
      get 'players'
      response.should_not be_success
    end

    it "should return http failure after entered user credential" do
      user_auth
      get 'players'
      response.should_not be_success
    end

    it "returns http success after entered admin credential" do
      admin_auth
      get 'players'
      response.should be_success
      response.headers['Content-Disposition'].should include 'filename="player_data.csv"'
      response.headers['Content-Type'].should include 'text/csv'
    end
  end
  
  describe "GET 'answered_correctly'" do
    it "should return http failure when not enter credential" do
      get 'answered_correctly'
      response.should_not be_success
    end

    it "should return http failure after entered user credential" do
      user_auth
      get 'answered_correctly'
      response.should_not be_success
    end

    it "returns http success after entered admin credential" do
      admin_auth
      get 'answered_correctly'
      response.should be_success
      response.headers['Content-Disposition'].should include 'filename="answered_correctly_data.csv"'
      response.headers['Content-Type'].should include 'text/csv'
    end
  end

end
