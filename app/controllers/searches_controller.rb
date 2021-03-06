class SearchesController < ApplicationController
  
  def new 
  end
  
  def show
    @search = Search.find(params[:id])
    @lots = @search.find_lots
     respond_to do |format|
      format.html
      format.csv { send_data @lots.to_csv, filename: "LDMS-Search-" + @search.id.to_s + "-Results.csv"}
     end 
  end
  
  def create
    @search = Search.new(search_params)
    @search.user_id = current_user.id
    if @search.save
      redirect_to @search
    else
      flash[:alert] = "Search error please try again"
      redirect_to @search
    end
  end
  
  private

    def search_params
      params.require(:search).permit(:from,
                                     :to,
                                     :lot,
                                     :client,
                                     :samp_id,
                                     :com,
                                     :site,
                                     :phylum,
                                     :l_class,
                                     :genus,
                                     :species) 
    end
end