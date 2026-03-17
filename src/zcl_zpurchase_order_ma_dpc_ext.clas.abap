class ZCL_ZPURCHASE_ORDER_MA_DPC_EXT definition
  public
  inheriting from ZCL_ZPURCHASE_ORDER_MA_DPC
  create public .

public section.
protected section.

  methods PURCHASEORDERMTR_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZPURCHASE_ORDER_MA_DPC_EXT IMPLEMENTATION.


  method PURCHASEORDERMTR_GET_ENTITYSET.
DATA: ls_ebeln               TYPE EKKO-ebeln,
      LT_tab         TYPE table of zstr_final1,
      ls_tab type zstr_final1,
      LS_ebeln_SELECT_OPTIONS LIKE LINE OF IT_FILTER_SELECT_OPTIONS,
      LS_ebeln_SELECT         LIKE LINE OF LS_ebeln_SELECT_OPTIONS-SELECT_OPTIONS,
      LS_ENTITY               LIKE LINE OF ET_ENTITYSET.



  READ TABLE IT_FILTER_SELECT_OPTIONS INTO LS_ebeln_SELECT_OPTIONS WITH KEY PROPERTY = 'PurchaseDoc'.
      READ TABLE LS_ebeln_SELECT_OPTIONS-SELECT_OPTIONS INTO LS_ebeln_SELECT INDEX 1.
      ls_ebeln = LS_ebeln_SELECT-LOW.
      CALL FUNCTION 'ZMTR1'
       EXPORTING
         LV_EBELN       = ls_ebeln
       TABLES
         LT_FINAL       = lt_tab
*         RETURN         =
                .

loop at lt_tab into ls_tab.
  ls_entity-ebeln = ls_tab-ebeln.
  ls_entity-mandt = ls_tab-mandt.
  ls_entity-lv_ebeln = ls_tab-ebeln.

  CALL FUNCTION 'CONVERSION_EXIT_ATINN_OUTPUT'
   EXPORTING
     INPUT        =   ls_TAB-atinn
  IMPORTING
    OUTPUT        =   ls_TAB-atinn
           .
  ls_entity-atinn = ls_tab-atinn.
  ls_entity-vbeln = ls_tab-vbeln.
  ls_entity-kunnr = ls_tab-kunnr.
  ls_entity-bstnk = ls_tab-bstnk.
  ls_entity-bstdk = ls_tab-bstdk.
  ls_entity-matnr = ls_tab-matnr.
  ls_entity-maktx = ls_tab-maktx.
  ls_entity-zsize = ls_tab-zsize.
  ls_entity-atwrt = ls_tab-atwrt.
  ls_entity-class = ls_tab-class.
  ls_entity-shell_test = ls_tab-shell_test.
  ls_entity-seat_test = ls_tab-seat_test.
  ls_entity-pneumatic = ls_tab-pneumatic.
  ls_entity-name1 = ls_tab-name1.
  ls_entity-menge = ls_tab-menge.
  ls_entity-tdline = ls_tab-tdline.
  append ls_entity to et_entityset.
  clear ls_entity.

  ENDLOOP.
    COMMIT WORK.
  endmethod.
ENDCLASS.
