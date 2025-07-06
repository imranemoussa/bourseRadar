class ProcessStockDataJob < ApplicationJob
  queue_as :market_data

  def perform(stock_symbol)
    Rails.logger.info "Début du traitement des données pour #{stock_symbol}"
    
    # Simuler un traitement long
    3.times do |i|
      sleep 2
      Rails.logger.info "Traitement #{i+1}/3 pour #{stock_symbol}"
    end
    
    Rails.logger.info "Traitement terminé pour #{stock_symbol}"
  end
end