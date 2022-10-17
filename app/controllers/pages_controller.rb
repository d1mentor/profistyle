class PagesController < ApplicationController
	#Методы страничек
	def home
		render_page_by_lang("home", params[:lang])
	end

	def about
		render_page_by_lang("about", params[:lang])
	end

	def contacts
		render_page_by_lang("contacts", params[:lang])
	end

	def portfolio
		render_page_by_lang("portfolio", params[:lang])
	end

	def services
		render_page_by_lang("services", params[:lang])
	end

	def blog
		@posts = BlogPost.all.reverse
		render_blog_by_lang(params[:lang], @posts)
	end

	def show_post
		@post_ver = BlogPost.find_by(id: params[:id])
		@post = BlogPost.new
		@post.post_intro = @post_ver.post_intro

		case get_lang
		when "ru"
			if check_valid_post_for_lang(@post_ver.text_ru, @post_ver.post_intro, @post_ver.name_ru, @post_ver.metatitle_ru, @post_ver.metadescription_ru, @post_ver.alt_ru)
			  @post.alt_ru = @post_ver.alt_ru
			  @post.name_ru = @post_ver.name_ru
			  @post.text_ru = @post_ver.text_ru
			  @post.metatitle_ru = @post_ver.metatitle_ru
			  @post.metadescription_ru = @post_ver.metadescription_ru
			  render "pages/show_post", post: @post
			else
			  redirect_to "/blog?lang=ru"
			end	
		when "pl"
			if check_valid_post_for_lang(@post_ver.text_pl, @post_ver.post_intro, @post_ver.name_pl, @post_ver.metatitle_pl, @post_ver.metadescription_pl, @post_ver.alt_pl)
			  @post.alt_ru = @post_ver.alt_pl
			  @post.name_ru = @post_ver.name_pl
			  @post.text_ru = @post_ver.text_pl
			  @post.metatitle_ru = @post_ver.metatitle_pl
			  @post.metadescription_ru = @post_ver.metadescription_pl
			  render "pages/show_post", post: @post
			else
			  redirect_to "/blog?lang=pl"
			end	
		when "en"
			if check_valid_post_for_lang(@post_ver.text_en, @post_ver.post_intro, @post_ver.name_en, @post_ver.metatitle_en, @post_ver.metadescription_en, @post_ver.alt_en)
			  @post.alt_ru = @post_ver.alt_en
			  @post.name_ru = @post_ver.name_en
			  @post.text_ru = @post_ver.text_en
			  @post.metatitle_ru = @post_ver.metatitle_en
			  @post.metadescription_ru = @post_ver.metadescription_en
			  render "pages/show_post", post: @post
			else
			  redirect_to "/blog?lang=en"
			end	
		else
			@post.alt_ru = @post_ver.alt_ru
			@post.name_ru = @post_ver.name_ru
			@post.text_ru = @post_ver.text_ru
			@post.metatitle_ru = @post_ver.metatitle_ru
			@post.metadescription_ru = @post_ver.metadescription_ru
			render "pages/show_post", post: @post
		end		
	  end

	def services_ror
		render_page_by_lang("services_ror", params[:lang])
	end

	def services_cms
		render_page_by_lang("services_cms", params[:lang])
	end

	def services_cmr
		render_page_by_lang("services_cmr", params[:lang])
	end

	def services_seo
		render_page_by_lang("services_seo", params[:lang])
	end

	def contacts_form_send
		SendFormMailer.with(name: params[:name], email: params[:email], subject: params[:subject], message: params[:message]).send_form.deliver_later

		case get_lang
		when "ru"
			msg = "Ваше письмо успешно отправлено!"
		when "en"
			msg = "Email sent successfully!"
		when "pl"
			msg = "Wysłany e-mail z pomyślnie!"
		end	
		
		redirect_to "/contacts?lang=#{params[:lang]}", notice: "#{msg}"
	end	


	private

	def check_valid_post_for_lang(text, post_intro, name, metatitle, metadescription, alt)
        if text == "" || post_intro.url.nil? || name == "" || metatitle == "" || metadescription == "" || metatitle == nil || metadescription == nil || alt == "" || alt == nil 
            false
        else
            true    
        end    
    end  

	def get_lang
		if params[:lang] == nil || params[:lang] == ""
			lang = get_preffered_language
		else 
			params[:lang]
		end		
	end
	

	def render_page_by_lang(dir_name, lang)
		if lang == nil || lang == ""
			lang = get_preffered_language
		end 

		case lang
			when "ru"
				render "pages/#{dir_name}_langs/ru"
			when "pl"
				render "pages/#{dir_name}_langs/pl"
			when "en" 
				render "pages/#{dir_name}_langs/en"
			else
				render "pages/#{dir_name}_langs/pl"
		end
	end

	def render_blog_by_lang(lang, posts)
		if lang == nil || lang == ""
			lang = get_preffered_language
		end 

		case lang
			when "ru"
				render "pages/blog_langs/ru", posts: posts
			when "pl"
				render "pages/blog_langs/pl", posts: posts
			when "en" 
				render "pages/blog_langs/en", posts: posts
			else
				render "pages/blog_langs/pl", posts: posts
		end
	end	

	#Метод автоопределния предпочтиемого языка пользователя
	def get_preffered_language
		rx = /([A-Za-z]{2}(?:-[A-Za-z]{2})?)(?:;q=(1|0?\.[0-9]{1,3}))?/
		langs = request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(rx).map do |lang, q| 
			[lang, (q || '1').to_f]
		end	
  		preffered_lang = langs.sort_by(&:last).map(&:first).reverse.first

  		case preffered_lang
  			when "ru-RU"
  				"ru"
  			when "ru"
  				"ru"
  			when "en-US"
  				"en"
  			when "en"
  				"en"
  			when "pl-PL"
  				"pl"
  			when "pl"
  				"pl"
  			when "*"
  				"en"
  			when nil
  				"en"	
  		end	
	end
end
