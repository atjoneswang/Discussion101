class PostsController < ApplicationController
  
  before_action :authenticate_user!
  #before_action :find_group
  before_action :member_required, only: [:new, :create]
  
  def new
    @post = Post.new(:group_id => params[:group_id])
  end
  
  def edit
    @post = current_user.posts.find(params[:id])
  end
  
  def create
    @post = Post.new(:group_id => params[:group_id], :content => post_params[:content])
    @post.author = current_user
    if @post.save
      redirect_to group_path(params[:group_id]), notice: "新增文章成功"
    else
      render :new
    end
  end
  
  def update
    @update = Post.where(:user_id => current_user, :id => params[:id]).update_all(:content => post_params[:content])
    if @update
      redirect_to group_path(params[:group_id]), notice: "文章修改成功"
    end
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.delete
    redirect_to group_path(params[:group_id]), alert: "文章已刪除"
  end
  
  private
  def post_params
    params.require(:post).permit(:content)
  end
  
  def member_required
    return if !current_user.is_member_of?(@group)
    flash[:warning] = "你不是這個討論板的成員，不能發文"
    redirect_to group_path(@group)
  end
end
