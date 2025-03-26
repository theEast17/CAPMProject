namespace india.db;

using {
    india.db.master,
    india.db.transaction
} from './datamodel';

context CDSViews {
    define view ![PODetails] as
        select from transaction.purchaseorder {
            key PO_ID                             as ![purchaseorders_id],
                PARTNER_GUID.BP_ID                as ![vendor_id],
                PARTNER_GUID.COMPANY_NAME         as ![company_name],
                GROSS_AMOUNT                      as ![POGross_Amount],
                CURRENCY_CODE                     as ![POCurrency_Code],
            key Items.PO_ITEM_POS                 as ![ItemPosition],
                Items.PRODUCT_GUID.PRODUCT_ID     as ![ProductId],
                Items.PRODUCT_GUID.DESCRIPTION    as ![Product_Description],
                PARTNER_GUID.ADDRESS_GUID.CITY    as ![city],
                PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![country],
                Items.GROSS_AMOUNT                as ![GrossAmount],
                Items.NET_AMOUNT                  as ![NetAmount]

        }

    define view ![itemView] as
        select from transaction.poitems {
            key PARENT_KEY.PARTNER_GUID.NODE_KEY as ![Vendor],
                PRODUCT_GUID.NODE_KEY            as ![ProductId],
                CURRENCY_CODE                    as ![CurrencyCode],
                NET_AMOUNT                       as ![NetAmount],
                TAX_AMOUNT                       as ![TaxAmount],
                PARENT_KEY.OVERALL_STATUS        as ![POStatus]
        }

    define view ProductSum as
        select from master.product as prod {
            key PRODUCT_ID        as ![ProductId],
                texts.DESCRIPTION as ![Description],
                (
                    select from transaction.poitems as a {
                        SUM(
                            a.GROSS_AMOUNT
                        ) as SUM
                    }
                    where
                        a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
                )                 as PO_SUM : Decimal(10, 2)
        }

}
