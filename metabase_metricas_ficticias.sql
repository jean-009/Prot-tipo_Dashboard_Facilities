-- Este arquivo contém os 6 scripts SQL usados no Metabase
-- para gerar os gráficos de apresentação (dados fictícios/hardcoded).
-- Este é o arquivo a ser salvo no GitHub como 'metabase_metricas_ficticias.sql'.

-- ===================================================================
-- GRÁFICO 1: TENDÊNCIA DE OCORRÊNCIAS MENSAIS (LINHA)
-- Visualização Sugerida: Gráfico de Linha ou Área.
-- ===================================================================
WITH meses_ficticios AS (
    -- Gera uma série de 4 meses
    SELECT 
        DATE_TRUNC('month', generate_series(
            (CURRENT_DATE - INTERVAL '3 months')::date,
            CURRENT_DATE,
            '1 month'::interval
        )) AS mes_ocorrencia
)
SELECT
    -- Eixo X: Mês
    mf.mes_ocorrencia,
    
    -- Eixo Y: Injeta valores que simulam um leve aumento de demanda
    CASE 
        WHEN mf.mes_ocorrencia = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '3 months') THEN 120  -- 3 meses atrás
        WHEN mf.mes_ocorrencia = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '2 months') THEN 135  -- 2 meses atrás
        WHEN mf.mes_ocorrencia = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month') THEN 140  -- Último mês
        WHEN mf.mes_ocorrencia = DATE_TRUNC('month', CURRENT_DATE) THEN 155  -- Mês atual
        ELSE 130
    END AS total_ocorrencias
FROM
    meses_ficticios mf
ORDER BY
    mf.mes_ocorrencia;


-- ===================================================================
-- GRÁFICO 2: DESPESAS TOTAIS POR FORNECEDOR (COLUNA)
-- Visualização Sugerida: Gráfico de Coluna (Barra).
-- ===================================================================
SELECT
    -- Eixo X: Nome Fictício do Fornecedor
    fornecedor_nome,
    
    -- Eixo Y: Valor total da despesa (Hardcode)
    despesa_total
FROM (
    VALUES 
        ('Alpha Service', 75000.00),
        ('Beta Soluções', 55000.00),
        ('Gama Manutenção', 30000.00),
        ('Delta Limpeza', 15000.00)
) AS despesas (fornecedor_nome, despesa_total);


-- ===================================================================
-- GRÁFICO 3: PROPORÇÃO DE CLIENTES POR REGIÃO (PIZZA/DONUT)
-- Visualização Sugerida: Gráfico de Pizza ou Donut.
-- ===================================================================
SELECT
    -- Agrupamento: Região Fictícia
    regiao,
    
    -- Contagem: Número de Clientes Fictícios
    total_clientes
FROM (
    VALUES 
        ('Sudeste', 450),
        ('Sul', 280),
        ('Nordeste', 150),
        ('Centro-Oeste', 80),
        ('Norte', 40)
) AS clientes_regiao (regiao, total_clientes)
ORDER BY
    total_clientes DESC;


-- ===================================================================
-- GRÁFICO 4: DETALHE DAS ÚLTIMAS OCORRÊNCIAS (TABELA)
-- Visualização Sugerida: Tabela.
-- ===================================================================
SELECT
    id_ocorrencia,
    id_contrato,
    data_registro_ocorrencia,
    dias_para_resolucao,
    status_resolucao
FROM (
    VALUES
        (1005, 'CT012', CURRENT_DATE - INTERVAL '5 days', 2, 'Fechado'),
        (1006, 'CT045', CURRENT_DATE - INTERVAL '4 days', 1, 'Fechado'),
        (1007, 'CT088', CURRENT_DATE - INTERVAL '3 days', 0, 'Em Aberto'),
        (1008, 'CT012', CURRENT_DATE - INTERVAL '1 day', 1, 'Fechado'),
        (1009, 'CT099', CURRENT_DATE, 0, 'Em Aberto')
) AS ultimas_ocorrencias (id_ocorrencia, id_contrato, data_registro_ocorrencia, dias_para_resolucao, status_resolucao)
ORDER BY data_registro_ocorrencia DESC;


-- ===================================================================
-- GRÁFICO 5: LUCRO POR CONTRATO ESPECÍFICO (KPI)
-- Visualização Sugerida: Número (KPI) ou Gauge.
-- Query corrigida para não depender de tabelas vazias (ex: valor_recebido)
-- ===================================================================
SELECT
    -- Lucro = Receita Total - Despesa Total
    (75000.00 - 50000.00) AS lucro_contrato;


-- ===================================================================
-- GRÁFICO 6: TURNOVER MENSAL (LINHA DUPLA)
-- Visualização Sugerida: Gráfico de Linha (com duas séries).
-- ===================================================================
SELECT
    mes,
    -- Usa CASE para criar duas colunas separadas para Admissão e Demissão
    SUM(CASE WHEN tipo_movimento = 'Admissão' THEN contagem ELSE 0 END) AS admissoes,
    SUM(CASE WHEN tipo_movimento = 'Demissão' THEN contagem ELSE 0 END) AS demissoes
FROM (
    VALUES
        -- Mês 1: Admissão e Demissão
        (DATE_TRUNC('month', CURRENT_DATE - INTERVAL '3 months'), 'Admissão', 5),
        (DATE_TRUNC('month', CURRENT_DATE - INTERVAL '3 months'), 'Demissão', 3),
        -- Mês 2: Admissão e Demissão
        (DATE_TRUNC('month', CURRENT_DATE - INTERVAL '2 months'), 'Admissão', 7),
        (DATE_TRUNC('month', CURRENT_DATE - INTERVAL '2 months'), 'Demissão', 5),
        -- Mês 3: Admissão e Demissão
        (DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month'), 'Admissão', 4),
        (DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month'), 'Demissão', 6)
) AS turnover (mes, tipo_movimento, contagem)
GROUP BY mes
ORDER BY mes;
