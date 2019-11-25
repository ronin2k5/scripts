create view v_port_clean as select trim(substr(name, 0, instr(name, '@'))) as name from port;
create view v_port_duplicate as select p.name from v_port_clean as p left outer join portdependency as pd on pd.dependency=p.name where pd.port is null and p.name in (select name from brewinstalled);
create view v_independant_port as select p.name from v_port_clean as p left outer join portdependency as pd on pd.dependency=p.name where pd.port is null;
create view v_port2brew as select name from v_independant_port where name in (select name from brew) and name not in (select name from brewinstalled);
