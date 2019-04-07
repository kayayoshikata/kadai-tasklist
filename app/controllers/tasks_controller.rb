class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in    
    before_action :correct_user

    def index
        if logged_in?
        
            @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
        end
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = current_user.tasks.build(task_params)
        
        
        if @task.save
            flash[:success] = 'task作成完了'
            redirect_to @task
        else
            flash.now[:danger] = 'task作成失敗'
            render :new
        end
    end

    def edit
    end

    def update
        
        if @task.update(task_params)
            flash[:success] = 'task修正完了'
            redirect_to @task
        else
            flash.now[:danger] = 'task修正失敗'
            render :edit
        end
    end

    def destroy
        @task.destroy
        
        flash[:success] = 'task削除完了'
        redirect_to tasks_url(fallback_location: root_path)
        
    end

    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    
    
    #StrongParameter
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
          redirect_to root_url
        end
    end
    

end
