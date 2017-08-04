class UrlGeneratorsController < ApplicationController
  def index
    #get all the URL's based on no of visit
    @url_generators = UrlGenerator.order('visit_count desc')
  end
  def new
    @url_generator = UrlGenerator.new
  end
  def create   
    exixt = false
    @url_generator = UrlGenerator.new(url_generator_params)
    begin
      #generating new key
      url_key = SecureRandom.urlsafe_base64(4, false)
      #checking key with existing keys
      exixt = check_key_exist(url_key)
    end while exist=false
    #save new row data into key-pair form
    hash = { url: params[:url_generator][:url], key: url_key }
    UrlGenerator.new(hash).save
    redirect_to action: 'index'
  end
  #returns false if generated key is already present
  def check_key_exist url_key
    @url_generators = UrlGenerator.all
    @url_generators.each do |url_generator|
      if url_generator.key == url_key
        return true
      end
    end
    return false
  end
  def redirect_user
    url = get_url_key(params[:id]) 
    if url then
      if url.include? "http"
        redirect_to url
      else
        redirect_to "http://"+url
      end
    else
      render_404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url_generator
      @url_generator = UrlGenerator.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def url_generator_params
      params.require(:url_generator).permit(:url)
    end
    def get_url_key(url_key)
      #check requested url in database 
      @url_generators = UrlGenerator.all
      @url_generators.each do |url_generator|
        if url_generator.key == url_key
          visit_count = (url_generator.visit_count.to_i)+1
          url_generator.update(visit_count: visit_count)
          return url_generator.url
        end
      end
      return false
    end
    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", 
                             :layout => false, 
                             :status => :not_found 
                    }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end
end
