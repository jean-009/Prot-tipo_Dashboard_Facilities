Projeto de BI de Facilities

Este repositório documenta o processo completo de criação de um Data Warehouse (DW) protótipo e um Dashboard de Business Intelligence (BI) para a área de Facilities. O projeto aborda desde a extração de dados brutos (CSV) até a modelagem de métricas de negócio e visualização no Metabase.

1. Visão Geral do Projeto

O objetivo deste projeto é centralizar dados operacionais e financeiros de Facilities (como ocorrências, contratos, receitas e despesas) em um único Data Warehouse (PostgreSQL) para permitir a análise de performance e a tomada de decisão através de um dashboard no Metabase.

Arquitetura da Solução

Fontes de Dados: Arquivos CSV brutos (ex: Ocorrencias_Operacionais.csv, Valor_Recebido.csv, Clientes.csv).

ETL & Banco de Dados: Scripts Python (Pandas) para limpeza, transformação (saneamento de datas, correção de formatos monetários) e carga (Load) em um banco de dados PostgreSQL rodando em Docker.

Modelagem & BI: O Metabase é conectado ao PostgreSQL. As métricas de negócio são modeladas usando SQL Nativo (Queries Nativas) dentro do Metabase.

Visualização: Um dashboard consolidado exibe os KPIs e gráficos de tendência.

2. Modelagem de Dados e Métricas de Negócio

Durante a fase de depuração e modelagem no Metabase, descobrimos que os dados de exemplo (mockados) estavam incompletos (chaves estrangeiras ausentes ou dados zerados). Para fins de apresentação, utilizamos queries SQL que injetam dados fictícios (Hardcoded/VALUES) para simular um dashboard funcional.

Abaixo estão as 6 principais métricas e gráficos definidos para o dashboard:

Gráfico 1: Tendência de Ocorrências (Gráfico de Linha)

Propósito: Monitorar a demanda operacional de Facilities ao longo do tempo.

Eixo X: Mês (gerado via generate_series).

Eixo Y: Total de Ocorrências (valor fictício).

Gráfico 2: Despesas por Fornecedor (Gráfico de Coluna)

Propósito: Comparar o custo dos principais fornecedores de serviço.

Eixo X: Nome do Fornecedor.

Eixo Y: Despesa Total (valor fictício).

Gráfico 3: Clientes por Região (Gráfico de Pizza)

Propósito: Entender a distribuição geográfica da base de clientes.

Agrupamento: Região (valor fictício).

Valor: Contagem de Clientes (valor fictício).

Gráfico 4: Tabela de Últimas Ocorrências (Tabela)

Propósito: Fornecer uma visão detalhada (Drill-down) das atividades recentes.

Visualização: Tabela com as últimas 5 ocorrências fictícias.

Gráfico 5: KPI de Lucro do Contrato (KPI/Número)

Propósito: Avaliar rapidamente a saúde financeira de um contrato chave.

Visualização: KPI (Número) formatado como Moeda.

Cálculo: (Receita Fictícia - Despesa Fictícia).

Gráfico 6: Turnover (Admissão vs. Demissão) (Gráfico de Linha Dupla)

Propósito: Monitorar a saúde do RH (Turnover).

Eixo X: Mês.

Eixo Y (Série 1): Total de Admissões (valor fictício).

Eixo Y (Série 2): Total de Demissões (valor fictício).

3. Próximos Passos (Produção)

Este projeto é um protótipo. Para movê-lo para produção, as seguintes etapas seriam necessárias:

Desenvolver o Pipeline de ETL: Substituir os dados fictícios (SQL VALUES) por um pipeline de ETL robusto (Python) que leia os arquivos CSV reais da empresa.

Agendamento (Orquestração): Agendar a execução do pipeline de ETL (ex: via Airflow) para atualizar o PostgreSQL diariamente.

Agendamento do Metabase: Configurar o Metabase para escanear o banco de dados e atualizar os dashboards automaticamente.
