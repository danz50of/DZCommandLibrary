 SELECT a.routing_revision, a.alternative_no
      FROM   ROUTING_ALTERNATE_TAB a, ROUTING_HEAD_TAB h
      WHERE to_date('4-Apr-2013') BETWEEN h.phase_in_date AND
               NVL(h.phase_out_date, to_date('4-Apr-2013'))
      AND   a.rowstate = 'Buildable'
      AND   a.routing_revision = h.routing_revision
      AND   h.bom_type = 'M'
      AND   a.bom_type = 'M'
      AND   h.contract = 'MP'
      AND   a.contract = 'MP'
      AND   h.part_no = '201-0507'
      AND   a.part_no = '201-0507'