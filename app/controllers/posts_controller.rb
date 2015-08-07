class PostsController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @post = Post.new(:group_id => params[:group_id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(:group_id => params[:group_id], :content => post_params[:content])
    if @post.save
      redirect_to group_path(params[:group_id]), notice: "新增文章成功"
    else
      render :new
    end
  end
  
  def update
    @update = Post.where(:group_id => params[:group_id], :id => params[:id]).update_all(:content => post_params[:content])
    if @update
      redirect_to group_path(params[:group_id]), notice: "文章修改成功"
    end
  end
  
  def destroy
    Post.delete(params[:id])
    redirect_to group_path(params[:group_id]), alert: "文章已刪除"
  end
  
  private
  def post_params
    params.require(:post).permit(:content)
  end
end
