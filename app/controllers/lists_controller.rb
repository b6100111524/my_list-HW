class ListsController < ApplicationController
  # before_action :set_list, :only => [:show, :edit, :update, :destroy] #同理可自行定義私有方法 :find_list
  before_action :find_list, only: %i[show edit update destroy]          
  
  # 0. index action建立
  def index
    #宣告實例變數lists
    @lists = List.order(duedate: :asc) #用時間排序 近到遠 << 修改後 #@lists = List.all
  end

  # 1. CRUD create > new action建立
  def new
    @list = List.new
  end

  # 1. CRUD create > create action建立
  def create
    @list = List.new(list_params)
    if @list.save                   # 判斷儲存驗證是否成功 成功回到index 失敗返回new
      flash[:notice] = 'One List Created!'
      redirect_to :action => :index # 等同於 lists_url
    else
      render :new                   # 等同於 :action => :new
    end
  end

  # 2. CRUD read > show action建立
  def show; end # @list = List.find(params[:id]) 取代為 :set_list

  # 3. CRUD update > edit action建立
  def edit; end # @list = List.find(params[:id]) 取代為 :set_list

  # 3. CRUD update > update action建立
  def update    # @list = List.find(params[:id]) 取代為 :set_list
    # 判斷更新驗證是否成功
    if @list.update_attributes(list_params)      # update_attributes 將修改內容送回資料庫
      flash[:notice] = 'One List Updated!'
      redirect_to :action => :show, :id => @list # 等同於 list_path(@list)
    else
      render :edit
    end
  end

  # 4. CRUD destroy > destroy action建立 
  def destroy # @list = List.find(params[:id]) 取代為 :set_list 
    if @list.can_destroy? #在 list.rb 定義 list.can_destroy
      @list.destroy
      flash[:alert] = 'One List Deletes!'
      redirect_to lists_path
    else
      flash[:alert] = 'List Overdue, Can not Deleted!'
      redirect_to lists_path
    end
  end


  private

  def find_list   # 避免被更改 自定義使用於 before_action :find_list
    @list = List.find(params[:id])
  end

  def list_params # 安全檢測使用 用來過濾使用者傳入的參數 "Strong Parameter"
    params.require(:list).permit(:title, :duedate, :note) # require 把 :list model的相關參數取出 # permit 指定可傳入哪些參數
  end
end


