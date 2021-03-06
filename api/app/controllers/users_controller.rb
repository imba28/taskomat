class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy, :new, :index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if params[:group_id]
      @users = Group.find(params[:group_id]).users
    else
      @users = User.all
    end

    respond_to do |format|
      format.html { render :index }
      format.json
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html { render :show, location: @user }
      format.json
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if params[:group_id] then
      @user = User.find(params[:id])
      group = Group.find(params[:group_id])

      if group.users.include?(@user) then
        respond_to do |format|
          format.html { redirect_to group_url, notice: 'User was successfully added to group.' }
          format.json { render json: group, status: :ok }
        end
      else
        group.users << @user
        respond_to do |format|
          format.html { redirect_to group_url, notice: 'User was successfully added to group.' }
          format.json { render json: group, status: :created }
        end
      end
    else
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :ok }

        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      Rails.logger.warn user_params

      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user.to_json(:only => [:id, :name, :created_at, :updated_at]) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if params[:group_id] then
      group = Group.find(params[:group_id]);

      if(group.admin_id == @user.id && group.users.length > 1) then
        respond_to do |format|
          format.html { render  }
          format.json { render json: '{"error": "Du must zuerst deine Rechte an eine andere Person übertragen!"}', status: :unprocessable_entity }
        end
        return
      end

      group.users.delete(@user)
      respond_to do |format|
        format.html { redirect_to groups_url, notice: 'User was successfully remove from Group.' }
        format.json { render json: '{"message": "Du hast die Gruppe verlassen!"}', status: :ok }
      end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password_digest, :password, :email)
    end
end