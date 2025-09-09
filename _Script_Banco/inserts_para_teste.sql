-- Inserir colaborador
INSERT INTO colaborador (nome, cpf, rg, data_nascimento, salario, id_genero, id_estado_civil, id_turno, id_tipo_contrato, id_grau_hierarquico, id_grau_educacional, id_nacionalidade, data_admissao)
VALUES ('João Silva', '11122233344', 'MG1234567', '1990-05-10', 2500.00, 1, 1, 1, 1, 1, 1, 1, '2022-01-01');

-- Inserir dependente
INSERT INTO dependente (id_colaborador, nome, cpf, rg, data_nascimento, relacionamento)
VALUES (1, 'Pedro Silva', '22233344455', 'SP9876543', '2015-08-10', 'Filho');

-- Inserir benefício
INSERT INTO beneficio (nome, valor_total, valor_descontado, status)
VALUES ('Vale Alimentação', 600.00, 50.00, 'Ativo');

INSERT INTO colaborador_beneficio (id_colaborador, id_beneficio, data_inicio)
VALUES (1, 1, '2022-01-01');

-- Inserir exame vencido
INSERT INTO exame (id_colaborador, data_exame, proximo_exame, descricao, status)
VALUES (1, '2022-01-01', '2023-01-01', 'Exame admissional', 'Vencido');

-- Inserir férias
INSERT INTO ferias (id_colaborador, data_inicio, data_fim, status)
VALUES (1, '2024-01-01', '2024-01-30', 'Concluído');

-- Inserir histórico salarial
INSERT INTO historico_salarial (id_colaborador, data_inicio, salario)
VALUES (1, '2022-01-01', 2500.00);