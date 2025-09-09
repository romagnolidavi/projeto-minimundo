# Projeto Banco de Dados - Sistema de RH

## 📌 Descrição
Este projeto implementa um banco de dados relacional para gerenciar colaboradores, departamentos, benefícios, dependentes, exames e histórico salarial em uma empresa.  

O banco foi modelado em PostgreSQL e atende aos requisitos definidos no minimundo fornecido.

---

## 📂 Estrutura do Repositório
- **1_DER/** → Diagrama Entidade-Relacionamento (PNG).
- **2_Documentacao/** → Regras de negócio e sugestões de melhorias.
- **3_Banco/**  
  - `criacao.sql` → Script de criação do banco.  
  - `inserts.sql` → Dados de teste para rodar consultas.  
- **4_Consultas/** → Consultas SQL pedidas no enunciado.

---

## 🚀 Como rodar
1. Criar o banco no PostgreSQL:
   ```bash
   createdb rh
