-- =============================================================================
-- Ajuste de SEQUENCES após importação de dados do Paradox
-- Execute APÓS carregar os dados nas tabelas (ex.: via COPY ou INSERT)
-- Garante que novos INSERTs recebam IDs acima do máximo existente
-- =============================================================================

SELECT setval(pg_get_serial_sequence('bairro', 'controle'), COALESCE((SELECT MAX(controle) FROM bairro), 1));
SELECT setval(pg_get_serial_sequence('ativi', 'controle'), COALESCE((SELECT MAX(controle) FROM ativi), 1));
SELECT setval(pg_get_serial_sequence('area', 'controle'), COALESCE((SELECT MAX(controle) FROM area), 1));
SELECT setval(pg_get_serial_sequence('grupo', 'controle'), COALESCE((SELECT MAX(controle) FROM grupo), 1));
SELECT setval(pg_get_serial_sequence('cnae', 'controle'), COALESCE((SELECT MAX(controle) FROM cnae), 1));
SELECT setval(pg_get_serial_sequence('comple', 'controle'), COALESCE((SELECT MAX(controle) FROM comple), 1));
SELECT setval(pg_get_serial_sequence('login', 'controle'), COALESCE((SELECT MAX(controle) FROM login), 1));
SELECT setval(pg_get_serial_sequence('contrib', 'controle'), COALESCE((SELECT MAX(controle) FROM contrib), 1));
SELECT setval(pg_get_serial_sequence('registro', 'controle'), COALESCE((SELECT MAX(controle) FROM registro), 1));
SELECT setval(pg_get_serial_sequence('andamentos', 'controle'), COALESCE((SELECT MAX(controle) FROM andamentos), 1));
SELECT setval(pg_get_serial_sequence('denuncia', 'controle'), COALESCE((SELECT MAX(controle) FROM denuncia), 1));
SELECT setval(pg_get_serial_sequence('atend', 'controle'), COALESCE((SELECT MAX(controle) FROM atend), 1));
SELECT setval(pg_get_serial_sequence('oficio', 'controle'), COALESCE((SELECT MAX(controle) FROM oficio), 1));
SELECT setval(pg_get_serial_sequence('requerimento', 'controle'), COALESCE((SELECT MAX(controle) FROM requerimento), 1));
SELECT setval(pg_get_serial_sequence('planta', 'controle'), COALESCE((SELECT MAX(controle) FROM planta), 1));
SELECT setval(pg_get_serial_sequence('tramitacao', 'controle'), COALESCE((SELECT MAX(controle) FROM tramitacao), 1));
SELECT setval(pg_get_serial_sequence('visitas', 'controle'), COALESCE((SELECT MAX(controle) FROM visitas), 1));
SELECT setval(pg_get_serial_sequence('rt', 'controle'), COALESCE((SELECT MAX(controle) FROM rt), 1));
SELECT setval(pg_get_serial_sequence('alvara', 'controle'), COALESCE((SELECT MAX(controle) FROM alvara), 1));
SELECT setval(pg_get_serial_sequence('alvlib', 'controle'), COALESCE((SELECT MAX(controle) FROM alvlib), 1));
SELECT setval(pg_get_serial_sequence('historico', 'controle'), COALESCE((SELECT MAX(controle) FROM historico), 1));
SELECT setval(pg_get_serial_sequence('veiculo', 'controle'), COALESCE((SELECT MAX(controle) FROM veiculo), 1));
SELECT setval(pg_get_serial_sequence('rdpf', 'controle'), COALESCE((SELECT MAX(controle) FROM rdpf), 1));
SELECT setval(pg_get_serial_sequence('rdpfarq', 'controle'), COALESCE((SELECT MAX(controle) FROM rdpfarq), 1));
SELECT setval(pg_get_serial_sequence('rmpf', 'controle'), COALESCE((SELECT MAX(controle) FROM rmpf), 1));
SELECT setval(pg_get_serial_sequence('tbcon', 'controle'), COALESCE((SELECT MAX(controle) FROM tbcon), 1));
SELECT setval(pg_get_serial_sequence('auxrelativ', 'controle'), COALESCE((SELECT MAX(controle) FROM auxrelativ), 1));
SELECT setval(pg_get_serial_sequence('caracter', 'controle'), COALESCE((SELECT MAX(controle) FROM caracter), 1));
