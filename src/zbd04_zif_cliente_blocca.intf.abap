interface ZBD04_ZIF_CLIENTE_BLOCCA
  public .
  METHODS blocca.
  METHODS sblocca.
  METHODS get_cod RETURNING VALUE(rv_cod) type kunnr.

endinterface.
