# To deliver this notification:
#
# MessageNotification.with(post: @post).deliver_later(current_user)
# MessageNotification.with(post: @post).deliver(current_user)

class MessageNotification < Noticed::Base
  deliver_by :database

  param :message

  # Define helper methods to make rendering easier.
  def message
    params[:message].content
  end

  def url
    messages_path(params[:message])
  end
end
