class SongsController < ApplicationController
  layout "songs"
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :set_songs, except: :crypto

  # GET /songs
  # GET /songs.json
  def index; end

  # GET /songs/1
  # GET /songs/1.json
  def show
    video = @song.youtube.gsub("watch?v=", "v/")
    picture = which_picture(@song.title)
    prepare_meta_tags({
      og: {
        url: request.url,
        site_name: "East Kin's Universe",
        title: "Song: " + @song.title,
        image: view_context.image_url(picture),
        video: { _: video, url: video, secure_url: video,
                type: 'application/x-shockwave-flash',
                width: 560, height: 315 },
        description: @song.lyric.html_safe,
        type: 'video.other'
      },
      twitter: {card: 'summary_large_image', image: view_context.image_url("want_to_image.png"), title: @song.title, description: @song.lyric }})
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit; end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = Song.find(params[:id])
  end

  def set_songs
    @songs = Song.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    params.require(:song).permit(:lyric, :title, :writers, :copyright, :active, :youtube, :facebook, :soundcloud)
  end


  def which_picture(title)
    if title == 'The Want To'
      'want_to_image.png'
    elsif title == 'Compensated'
      'compensated.png'
    elsif title == 'You Know Me, Right?'
      'know_me_right.png'
    end
  end
end
