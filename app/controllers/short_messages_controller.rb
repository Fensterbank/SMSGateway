require 'net/http'

class ShortMessagesController < ApplicationController
  before_filter :require_login

  def history
    @messages = ShortMessage.order('created_at DESC')
  end

  def new
    @message = ShortMessage.new
    messages = ShortMessage.all
    @numbers = Array.new
    messages.each do | message |
      @numbers.push("'#{message.sender}'") unless @numbers.include?("'#{message.sender}'")
      @numbers.push("'#{message.receiver}'") unless @numbers.include?("'#{message.receiver}'")
    end
  end

  def send_message
    @message = ShortMessage.new(params[:short_message])

    source = 'web'
    http_gateway_key = APP_CONFIG['key']
    http_params = "key=#{http_gateway_key}&to=#{@message.receiver}&from=#{@message.sender}&message=#{@message.message}&charset=UTF-8&route=directplus&cost=1&count=1&message_id=1&ref=#{source}&concat=1"
    url = URI.encode(APP_CONFIG['url'] + '?' + http_params)

    http = Net::HTTP.new('gw.mobilant.net')
    http = http.start
    req = Net::HTTP::Get.new(url)
    result = http.request(req).body.split(' ')
    @message.result = result[0]
    @message.mobilant_id = result[1]
    @message.cost = result[2]
    @message.count = result[3]
    @message.source = source

    @message.save
  end
end
