/* 1) Ache a tabela "users" no dataset "thelook_ecommerce", no projeto de dados públicos no BigQuery.
Traga como resultado um único campo distinto com as informações de forma organizada dos campos street_adress + city + state + country + postal_code */

SELECT DISTINCT
  id,
  CONCAT(street_address, ' - ',city, ' - ', state, ' - ', country, ' - ', postal_code) AS endereco
FROM bigquery-public-data.thelook_ecommerce.users;


/* 2) Ache a tabela  "top_terms no dataset do google trends, e descubra os termos, suas posições no rank
e áreas de pesquisa para os termos começados com N no dia 2023-04-30. Obs: não se esqueça de colocar essa
restrição de data no where,pois a tabela é grande e particionada (processa somente a data que você colocar). Ordene por rank.*/

SELECT
  term,
  rank,
  dma_name
FROM bigquery-public-data.google_trends.top_terms
WHERE 
  STARTS_WITH(term, 'N') IS TRUE 
  AND week = '2023-04-30'
  ORDER BY rank
  LIMIT 100;


/* 3) Ache a tabela stations no dataset new_york_subway e substitua no campo station_name, a palavra St por Street nos casos em que o final do nome da estação termine em Av por Avenue. Traga como resultado somente o campo station_name de forma distinta e restringindo apenas as linhas que tenham St ou Av no nome.*/

SELECT DISTINCT
  CASE
    WHEN station_name LIKE '%St' THEN REPLACE(station_name, 'St', 'Street')
    WHEN station_name LIKE '%Av' THEN REPLACE(station_name, 'Av', 'Avenue')
  END AS station_name
FROM bigquery-public-data.new_york_subway.stations
WHERE
  station_name LIKE '%St' OR station_name LIKE '%Av';
-- Observação: O REPLACE funciona como um substituidor de itens, ou seja, REPLACE(onde ocorrerá a substituição/ dado a ser trocado / novo dado que tomará lugar)


/* DESAFIO 4) No mesmo dataset do item anterior e tabela stop_times, extraia somente o nome do dia da semana do campo trip_id, considerando somente sábado e domingo como resposta ( utilize como restrição no where, usndo upper e lower também. Traga também o trip_id no select.*/

SELECT DISTINCT
  trip_id,
  CASE
    WHEN SPLIT(trip_id, '-')[ORDINAL(3)] = 'SI017' THEN SPLIT(trip_id, '-')[ORDINAL(4)]
    ELSE SPLIT(trip_id, '-')[ORDINAL(3)]
  END AS dia
FROM bigquery-public-data.new_york_subway.stop_times
WHERE
  LOWER (trip_id) LIKE '%sunday%' OR UPPER(trip_id) LIKE '%SATURDAY%'
































