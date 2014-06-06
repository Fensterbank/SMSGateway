require 'net/http'

class ShortMessageController < ApplicationController
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
    @message = ShortMessage.new(short_message_params)

    source = 'web'
    http_gateway_key = APP_CONFIG['key']
    http_params = "key=#{http_gateway_key}&to=#{@message.receiver}&from=#{@message.sender}&message=#{@message.message}&charset=UTF-8&route=lowcost&cost=1&count=1&message_id=1&ref=#{source}&concat=1"

    uri = URI.parse(URI.escape(APP_CONFIG['url'] + '?' + http_params))
    logger.info "Pfad: #{uri}"
    result = Net::HTTP.get(uri)

    result = result.split("\n")
    logger.info result.inspect
    @message.result = result[0]
    @message.mobilant_id = result[1]
    @message.cost = result[2]
    @message.count = result[3]
    @message.source = source

    @message.save
  end

  private
  def short_message_params
    params.require(:short_message).permit(:message, :receiver, :sender)
  end
end
