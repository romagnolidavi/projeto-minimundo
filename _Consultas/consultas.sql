-- Colaboradores ativos em um departamento
SELECT c.id_colaborador, c.nome, d.nome AS departamento
FROM colaborador c
JOIN colaborador_departamento cd ON c.id_colaborador = cd.id_colaborador
JOIN departamento d ON cd.id_departamento = d.id_departamento
WHERE c.data_demissao IS NULL;

-- Dependentes de um colaborador
SELECT d.id_dependente, d.nome, d.relacionamento, c.nome AS colaborador
FROM dependente d
JOIN colaborador c ON d.id_colaborador = c.id_colaborador;

-- Exames vencidos
SELECT c.nome, e.descricao, e.proximo_exame
FROM exame e
JOIN colaborador c ON e.id_colaborador = c.id_colaborador
WHERE e.proximo_exame < CURRENT_DATE;

-- Custo de benefícios por departamento
SELECT d.nome AS departamento, SUM(b.valor_total) AS custo_total
FROM colaborador c
JOIN colaborador_departamento cd ON c.id_colaborador = cd.id_colaborador
JOIN departamento d ON cd.id_departamento = d.id_departamento
JOIN colaborador_beneficio cb ON c.id_colaborador = cb.id_colaborador
JOIN beneficio b ON cb.id_beneficio = b.id_beneficio
GROUP BY d.nome;
