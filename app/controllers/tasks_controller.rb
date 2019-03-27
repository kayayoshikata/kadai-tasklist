class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        @tasks = Task.all
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        
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
        redirect_to tasks_url
        
    end

    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    
    
    #StrongParameter
    def task_params
        params.require(:task).permit(:content, :status)
    end

end
