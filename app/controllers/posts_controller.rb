# -*- encoding : utf-8 -*-
class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_post, :only => [:edit, :update, :destroy, :show]

  # GET /posts
  # GET /posts.json

  def get_post
      @post = Post.find_by_id(params[:id])

      if @post == nil
        flash[:notice] = "Não foi possível encontrar o post"
        redirect_to posts_url
      end
  end

  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #@post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new 
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    #@post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    @post = @user.posts.create(params[:post])
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post criado com sucesso.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    #@post = Post.find(params[:id])

    if @post.user != current_user
      flash[:notice] = "Você não tem permissão para editar este post"
      redirect_to posts_url
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post editado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    #@post = Post.find(params[:id])

    if @post.user != current_user
      flash[:notice] = "Você não tem permissão para apagar este post"
      redirect_to posts_url
    end

    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
