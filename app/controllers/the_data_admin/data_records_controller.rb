class TheDataAdmin::DataRecordsController < TheDataAdmin::BaseController
  before_action :set_data_list, only: [:show, :edit, :update, :rebuild, :destroy]

  def index
    @data_lists = DataRecord.page(params[:page])
  end

  def new
    @data_list = DataList.new(type: params[:type])
  end

  def create
    @data_list = DataList.new(data_list_params)
    @data_list.save

    redirect_to data_lists_url(type: @data_list.type)
  end

  def show
  end

  def edit
  end

  def update
    @data_list.update(data_list_params)
    redirect_to data_lists_url(type: @data_list.type)
  end

  def add_item
    @data_list = DataList.new
  end

  def remove_item

  end

  def rebuild
    @data_list.columns = @data_list.config_columns
    @data_list.save

    redirect_back fallback_location: data_lists_url
  end

  def destroy
    @data_list.destroy
    redirect_to data_lists_url, notice: 'Export file was successfully destroyed.'
  end

  private
  def set_data_list
    @data_list = DataList.find params[:id]
  end

  def data_list_params
    result = params[:data_list].permit(
      :type,
      :title,
      :comment,
      :data_table,
      :export_excel,
      :export_pdf,
      parameters: [:key, :value]
    )
    _params = result['parameters']&.values&.map { |i|  {i['key'] => i['value'] } }
    _params = Array(_params).to_combined_hash
    result['parameters'] = _params
    result
  end

end
