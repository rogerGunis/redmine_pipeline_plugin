class PipelineController < ApplicationController
  unloadable

  layout 'base'

  before_filter :require_admin
  menu_item :pipeline
  
  def report
    @users = User.active
    @statuses = IssueStatus.where(:is_closed => false)
    @trackers = Tracker.all
    @projects = Project.active
    @grouping_options = Pipeline::ValidGroupOptions

    @users_selected = @users.collect{ |x| x.id }
    @statuses_selected = @statuses.collect{ |x| x.id }
    @trackers_selected = @trackers.collect{ |x| x.id }
    @projects_selected = @projects.collect{ |x| x.id }
    @group = @grouping_options.keys.first()

    if params[:pipeline]
      @users_selected = params[:pipeline][:users]
      @statuses_selected = params[:pipeline][:statuses]
      @trackers_selected = params[:pipeline][:trackers]
      @projects_selected = params[:pipeline][:projects]
      @group = params[:pipeline][:group].to_sym if @grouping_options.include?(params[:pipeline][:group].to_sym)
    end

	non_assigned_issues = @users.size==@users_selected.size ? " assigned_to_id IS NULL " : " 0=1 "
    @todos = Issue.where('project_id in (:p_ids) ' +
                             'AND tracker_id IN (:t_ids) ' +
                             'AND status_id IN (:s_ids) ' +
                             'AND ( assigned_to_id IN (:u_ids) OR '+non_assigned_issues+' )',
	              :p_ids => @projects_selected,
	              :t_ids => @trackers_selected,
                  :s_ids => @statuses_selected,
	              :u_ids => @users_selected
			).includes(:tracker, :assigned_to, :project, :time_entries
			).order('project_id ASC, status_id DESC, tracker_id ASC')

  end

  def reset
    params[:pipeline].delete if params[:pipeline]
    redirect_to :action => 'report'
  end
  
 end