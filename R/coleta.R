# Pacotes ---------------------------------------------------------------------

# Carregar pacotes
library(rbcb)
library(purrr)
library(dplyr)
library(readr)

# Coleta de dados -------------------------------------------------------------

# Coleta via API da SGS/BCB
dados_brutos <- rbcb::get_series(code=c('IGP-M'=189,'IGP-DI'=190,'IPCA'=433, 'INPC'=188,'IPC-Br'=191),
start_date='2000-01-01',
as = 'tibble',
)

# Transformação de dados-------------------------------------------------------

# Tratamentos das tabelas
dados_tratados <- purrr::reduce(
  .x = dados_brutos,
  .f = dplyr::full_join,
  by = 'date'
) |>
  dplyr::arrange(date) 
  

# Armazenamento de dados

# Salvar tabelas como CSV
readr::write_csv(x=dados_tratados,file='dados_tratados.csv')

