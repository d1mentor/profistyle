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
		render_page_by_lang("blog", params[:lang])
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
		@order = { name: params[:name], email: params[:email], subject: params[:subject], message: params[:message] }
		SendFormMailer.with(order: @order).send_form.deliver_later
	end	


	private

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
