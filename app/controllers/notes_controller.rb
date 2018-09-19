class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all.where(user_id: current_user.id).order(created_at: :desc)

    if params[:toggle] == "false"
        @note = Note.where(id: params[:id])
        @note.update(:done => true)
    else
      @note = Note.where(id: params[:id])
        @note.update(:done => false)
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    p notes_params
    params[:notes][:notes].each do |notes|
      p notes[:note][:name]
      p notes[:note][:done]
      p notes[:note][:note]
      p notes[:note][:date] = DateTime.now
      p notes[:note][:user_id] = current_user.id

      @note = Note.new(:name => notes[:note][:name], 
                      :done => notes[:note][:done],
                      :note => notes[:note][:note], 
                      :date => notes[:note][:date],
                      :user_id => notes[:note][:user_id]).save

      end
    respond_to do |format|
        format.html { redirect_to root_path, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
   def notes_params
    params.require(:notes).permit({ 
      notes: [
        note: [
          :name, 
          :date,
          :done,
          :note
        ] 
      ]
    })
end

end
