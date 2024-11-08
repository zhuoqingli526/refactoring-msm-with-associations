class ActorsController < ApplicationController
  def index
    @list_of_actors = Actor.all.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_actor = Actor.where({:id => the_id }).at(0)
    
    render({ :template => "actor_templates/show" })
  end

  def create
    @the_actor = Actor.new
    @the_actor.name = params.fetch("query_name")
    @the_actor.dob = params.fetch("query_dob")
    @the_actor.bio = params.fetch("query_bio")
    @the_actor.image = params.fetch("query_image")

    if @the_actor.valid?
      @the_actor.save
      redirect_to("/actors", { :notice => "Actor created successfully." })
    else
      redirect_to("/actors", { :notice => "Actor failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @the_actor = Actor.where({ :id => the_id }).at(0)

    @the_actor.name = params.fetch("query_name")
    @the_actor.dob = params.fetch("query_dob")
    @the_actor.bio = params.fetch("query_bio")
    @the_actor.image = params.fetch("query_image")

    if @the_actor.valid?
      @the_actor.save
      redirect_to("/actors/#{@the_actor.id}", { :notice => "Actor updated successfully."} )
    else
      redirect_to("/actors/#{@the_actor.id}", { :alert => "Actor failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @the_actor = Actor.where({ :id => the_id }).at(0)

    @the_actor.destroy

    redirect_to("/actors", { :notice => "Actor deleted successfully."} )
  end
end
