class AdminPanelController < ApplicationController
  before_action :authenticate_user!, only: [:home, :spam_destroy, :messages, :message, :posts, :posts_base, :new_post, :create_post, :destroy_post, :edit_post, :update_post, :portfolio, :swap_spam_attr]

  def home
    render "admin_panel/home"
  end

  def spam_destroy
    @messages = FormMessage.where(spam: true).destroy_all
    redirect_to "/admin_panel/messages"
  end  

  def swap_spam_attr
    @message = FormMessage.find_by(id: params[:id])
    @message.spam = !@message.spam
    @message.save
    redirect_to "/admin_panel/messages" 
  end  

  def messages
    case params[:filter]
    when "readed"
      @messages = FormMessage.where(checked: true, spam: false).sort_by(&:created_at).reverse
    when "unreaded"
      @messages = FormMessage.where(checked: false, spam: false).sort_by(&:created_at).reverse
    when "spam"
      @messages = FormMessage.where(spam: true).sort_by(&:created_at).reverse
    else
      @messages = FormMessage.where(spam: false).sort_by(&:created_at).reverse
    end          
  end

  def message
    @message = FormMessage.find_by(id: params[:id])
    if !@message.checked
      @message.update(checked: true)
    end  
  end

  def create_message
    @message = FormMessage.new(email: params[:email], name: params[:name], subject: params[:subject], message_text: params[:message], sender_ip: request.env['REMOTE_ADDR'].to_s, sender_devise: request.env['HTTP_USER_AGENT'].to_s, sender_lang: params[:lang], checked: false, spam: false)
    if !message_check_hard_spam(@message)
      if !message_check_spam(@message)
        @message.save
      else
        @message.spam = true
        @message.save
      end  
    end
    send_push_notification
  end

  def send_push_notification
    api_instance = OneSignal::DefaultApi.new
    notification = OneSignal::Notification.new({app_id: '683d8a22-df80-4896-bdb5-70e83d6a34b8'}) # Notification | 

    # Create notification
    result = api_instance.create_notification(notification)
    p result
    rescue OneSignal::ApiError => e
    puts "Error when calling DefaultApi->create_notification: #{e}"
  end  

  def posts
    @posts = BlogPost.all.reverse

    render "admin_panel/blog/all_posts"
  end

  def posts_base
    @posts = BlogPost.all.reverse

    render "admin_panel/blog/posts_base"
  end  

  def new_post
    render "admin_panel/blog/new_post"
  end

  def create_post
    @post = BlogPost.new(post_params)
    @post.save!
    redirect_to "/admin_panel/posts_base"
  end

  def destroy_post
    @post = BlogPost.find_by(id: params[:id])
    @post.destroy
    redirect_to "/admin_panel/posts"
  end  

  def edit_post
    @post = BlogPost.find_by(id: params[:id])
    render "admin_panel/blog/post_edit", post: @post
  end

  def update_post
    @post = BlogPost.find_by(id: params[:id])
    @post.update(post_params)
    @post.save!
    redirect_to "/admin_panel/posts"
  end
  
  def portfolio
    render "admin_panel/portfolio/portfolio"
  end  

  private

  def message_check_spam(message)
    return true if message.message_text.include?("http")
    return true if message.message_text.include?(" @")
    return true if message.email.length > 99 || message.subject.length > 99 || message.name.length > 99 

    FormMessage.all.each do |msg|
      return true if msg.message_text == message.message_text
      return true if msg.sender_ip == message.sender_ip && (Time.now - msg.created_at) < 15 
    end
    
    return true if message.message_text == "" || message.message_text == nil || message.name == "" || message.name == nil || message.email == "" || message.email == nil || message.subject == "" || message.subject == nil 
  end  

  def message_check_hard_spam(message)
    FormMessage.all.each do |msg|
      return true if msg.sender_ip == message.sender_ip && (Time.now - msg.created_at) < 3
    end

    return true if message.message_text.length > 9999 || message.email.length > 999 || message.subject.length > 999 || message.name.length > 999 
  end  

  def post_params 
    params.permit(:name_ru, :name_pl, :name_en, :text_ru, :text_pl, :text_en, :metatitle_ru, :metatitle_pl, :metatitle_en, :metadescription_ru, :metadescription_pl, :metadescription_en, :alt_ru, :alt_pl, :alt_en, :post_intro)
  end  
end
