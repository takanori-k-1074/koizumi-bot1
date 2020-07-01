require 'line/bot'
require 'open-uri'
require 'kconv'
require 'rexml/document'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :validate_signature

  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      # config.channel_secret = "linedevelopers 環境設定済"
      # config.channel_token = "linedevelopers 環境設定済"
    }
  end
end