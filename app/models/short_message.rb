class ShortMessage < ActiveRecord::Base
  attr_accessible :message, :receiver, :sender, :count, :cost, :mobilant_id, :result, :source
end
