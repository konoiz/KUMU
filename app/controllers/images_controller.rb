class ImagesController < ApplicationController
  def start
      # default page
  end

  def index
      @image = Image.all
  end

  def show
      @image = Image.find(params[:id])
  end

  def new
      @image = Image.new
  end

  def create
      @image =Image.new(image_params)
      f = @image.file
      if f != nil
          saveName = Time.now.to_i.to_s + File.extname(f.original_filename)
          saveDir  = Rails.root.to_s + "/public/imgs/"

          File.open(saveDir + saveName, 'wb') do |of|
              of.write(f.read)
          end

          @image.filepath = '/imgs/' + saveName

          if @image.title == ""
              @image.title = f.original_filename
          end
              
      end

      if @image.save
          # create
          redirect_to '/images/show/' + @image.id.to_s
      else
          render 'new'
      end
  end

  private
    def image_params
        params.require(:image).permit(:filepath, :title, :description, :file)
    end
end
