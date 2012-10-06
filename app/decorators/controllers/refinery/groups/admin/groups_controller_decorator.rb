Refinery::Groups::Admin::GroupsController.class_eval do
  
  def index
    if current_refinery_user.has_role?("GroupAdmin") && !current_refinery_user.has_role?("Superuser")
      redirect_to refinery.groups_admin_group_path(current_refinery_user.group) and return
    end 
    if params[:search]
      @groups = Refinery::Groups::Group.where("lower(name) like ?", "%#{params[:search].downcase}%").paginate(:page => params[:page])
    else
      @groups = Refinery::Groups::Group.paginate(:page => params[:page])
    end
    
  end
  
  private
  
  def find_current_group
    if current_refinery_user.has_role?("GroupAdmin") && !current_refinery_user.has_role?("Superuser")
      @group = current_refinery_user.group
    else
      @group = Refinery::Groups::Group.find params[:id]
    end
    @is_guest_group = true if @group.name == "guest"
  end
  
end