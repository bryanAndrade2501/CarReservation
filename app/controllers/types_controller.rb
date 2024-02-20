class TypesController < ApplicationController
  before_action :set_type, only: %i[ edit update destroy ]
  before_action :authorize!

  # GET /types or /types.json
  def index
    @types = Type.all
  end

  # GET /types/new
  def new
    @type = Type.new
  end

  # GET /types/1/edit
  def edit
  end

  # POST /types or /types.json
  def create
    @type = Type.new(type_params)

    respond_to do |format|
      if @type.save
        format.html { redirect_to types_url, notice: "Type was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /types/1 or /types/1.json
  def update
    respond_to do |format|
      if @type.update(type_params)
        format.html { redirect_to types_url, notice: "Type was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /types/1 or /types/1.json
  def destroy
    @type.destroy!

    respond_to do |format|
      format.html { redirect_to types_url, notice: "Type was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_type
    @type = Type.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def type_params
    params.require(:type).permit(:name)
  end
end
