DROP DATABASE emprest_senai;
CREATE DATABASE emprest_senai
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

USE emprest_senai;

CREATE TABLE equipamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    tipo VARCHAR(100) NOT NULL,
    marca VARCHAR(100),
    categoria VARCHAR(100),
    statu_equipamento ENUM('Disponível', 'Emprestado', 'Manutenção') DEFAULT 'Disponível',
    area VARCHAR(100),
    fixo BOOLEAN DEFAULT 0,
    condicoes VARCHAR(255),
    observacoes VARCHAR(255),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    equipamento_id INT NOT NULL,
    usuario_id INT NOT NULL,
    data_emprestimo DATETIME NOT NULL,
    statu_emprestimo ENUM('Emprestado', 'Devolvido', 'Atrasado') DEFAULT 'Emprestado',
    danos VARCHAR(255),
    FOREIGN KEY (equipamento_id) REFERENCES equipamentos(id)
);
CREATE TABLE devolucoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emprestimo_id INT NOT NULL UNIQUE,
    equipamento_id INT NOT NULL,
	data_devolucao DATETIME,
	prazo_devolucao DATETIME NOT NULL,
    recebido_por VARCHAR(150),
    observacoes VARCHAR(255),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emprestimo_id) REFERENCES emprestimos(id) ON DELETE CASCADE,
    FOREIGN KEY (equipamento_id) REFERENCES equipamentos(id) ON DELETE CASCADE
);
INSERT INTO equipamentos (codigo, tipo, marca, categoria, statu_equipamento, area, fixo, condicoes, observacoes) VALUES
('C001', 'Notebook', 'Dell', 'Informática', 'Disponível', 'Sala 5', 0, 'Novo', 'Com bolsa'),
('M154', 'Furadeira', 'Bosch', 'Elétrica', 'Manutenção', 'Armário 3', 1, 'Com riscos', 'Faltando manual'),
('C45',  'Câmera DSLR', 'Canon', 'Audiovisual', 'Emprestado', 'Sala 2', 0, 'Faltando cabo', 'Sem carregador');

INSERT INTO emprestimos (equipamento_id, usuario_id, data_emprestimo, statu_emprestimo, danos) VALUES
(1, 1, '2025-09-10 14:35:00', 'Emprestado', 'Nenhum'),
(2, 2, '2025-09-12 09:15:00', 'Emprestado', 'Está c/ tela riscada'),
(3, 3, '2025-09-12 13:15:00', 'Devolvido', 'Tela riscada');

INSERT INTO devolucoes (emprestimo_id, equipamento_id, data_devolucao, prazo_devolucao, recebido_por, observacoes) VALUES
(3, 3, '2025-09-12 18:30:00', '2025-09-20 16:45:00', 'Admin', 'Recebido com dano');
;
