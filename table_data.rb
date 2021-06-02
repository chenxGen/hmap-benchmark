TABLE_LABELS = {case:'Case', average:'Average(s)', detail:'Detail(s)'}
module HmapBenckmark
  class TableData
    def initialize
        @datas = []
    end
    def append_data(title, costs, costs_with_plugin)
      ave_cost_origin=costs.sum/costs.size
      ave_cost_plugin=costs_with_plugin.sum/costs_with_plugin.size
      @datas << {case:"#{title} (origin)", average:"#{ave_cost_origin}", detail:"#{costs}"}
      @datas << {case:"#{title} (plugin)", average:"#{ave_cost_plugin}", detail:"#{costs_with_plugin}"}
      speed=(1.0/ave_cost_plugin - 1.0/ave_cost_origin)/(1.0/ave_cost_origin)
      time_saved_rate=(ave_cost_origin - ave_cost_plugin)/ave_cost_origin
      @datas << {case:"> optimization (speed)", average:"#{(speed*100).round(2)}%", detail:""}
      @datas << {case:"> optimization (time cost)", average:"#{(time_saved_rate*100).round(2)}%", detail:""}
    end
    def datas
      @datas || []
    end
  end
end
