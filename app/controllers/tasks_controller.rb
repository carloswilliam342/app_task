class TasksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_task, only: %i[ show edit update destroy ]

  
  def index
    @task = Task.all
  end

  
  def show
  end


  def new
    @task = current_user.tasks.new
  end


  def edit
  end

 
  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "A tarefa foi criada com sucesso." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Tarefa atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "A tarefa foi apagada com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    
    def set_task
      @task = Task.find(params[:id])
    end

    
    def task_params
      params.require(:task).permit(:titulo, :descricao)
    end
end
