class CompGroupsController < ApplicationController
  before_action :set_comp_group, only: [:show, :edit, :update, :destroy]

  # GET /comp_groups
  # GET /comp_groups.json
  def index
    @comp_groups = CompGroup.all
  end

  # GET /comp_groups/1
  # GET /comp_groups/1.json
  def show
  end

  # GET /comp_groups/new
  def new
    @comp_group = CompGroup.new
  end

  # GET /comp_groups/1/edit
  def edit
  end

  # POST /comp_groups
  # POST /comp_groups.json
  def create
    @comp_group = CompGroup.new(comp_group_params)

    respond_to do |format|
      if @comp_group.save
        format.html { redirect_to "/comp_groups", notice: 'Comp group was successfully created.' }
        format.json { render :show, status: :created, location: @comp_group }
      else
        format.html { render :new }
        format.json { render json: @comp_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comp_groups/1
  # PATCH/PUT /comp_groups/1.json
  def update
    respond_to do |format|
      if @comp_group.update(comp_group_params)
        format.html { redirect_to "/comp_groups", notice: 'Comp group was successfully updated.' }
        format.json { render :show, status: :ok, location: @comp_group }
      else
        format.html { render :edit }
        format.json { render json: @comp_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comp_groups/1
  # DELETE /comp_groups/1.json
  def destroy
    @comp_group.destroy
    respond_to do |format|
      format.html { redirect_to comp_groups_url, notice: 'Comp group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comp_group
      @comp_group = CompGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comp_group_params
      params.require(:comp_group).permit(:name, :owner_id)
    end
end
