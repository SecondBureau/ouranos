Refinery::Groups::Admin::GroupsController.class_eval do
  
  def index
    if current_refinery_user.has_role?("GroupAdmin")
      redirect_to refinery.groups_admin_group_path(current_refinery_user.group) and return
    end 
    @groups = Refinery::Groups::Group.paginate(:page => params[:page])
  end
  
  private
  
  def find_current_group
    if current_refinery_user.has_role?("GroupAdmin")
      @group = current_refinery_user.group
    else
      @group = Refinery::Groups::Group.find params[:id]
    end
    @is_guest_group = true if @group.name == "guest"
  end
  
end