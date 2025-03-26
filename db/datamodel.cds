namespace india.db;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {india.customAspect} from './customAspect';


context master {

    entity EVENTS{
        key ID:Integer;
        ENAME:String(30);
        ECITY:String(30)
    }

    entity worker : cuid, managed {
        firstName    : String(30);
        lastName     : String(30);
        Gender       : customAspect.Gender;
        phoneNumber  : customAspect.phoneNumber;
        email        : customAspect.Email;
        Currency     : String(3);
        salaryAmount : Decimal(15, 2);
    };

    entity businesspartner : managed {
        key NODE_KEY      : String(50)
            @title: '{i18n>bp_key}';
            BP_ROLE       : String(2)
            @title: '{i18n>bp_role}';
            EMAIL_ADDRESS : String(105)
            @title: '{i18n>email_address}';
            PHONE_NUMBER  : String(32)
            @title: '{i18n>phone_number}';
            FAX_NUMBER    : String(32)
            @title: '{i18n>fax_number}';
            WEB_ADDRESS   : String(44)
            @title: '{i18n>web_address}';
            ADDRESS_GUID  : Association to one address;
            BP_ID         : String(16)
            @title: '{i18n>bp_id}';
            COMPANY_NAME  : String(250)
            @title: '{i18n>company_name}';
    }

    entity address {
        key NODE_KEY        : String(50);
            CITY            : String(44);
            POSTAL_CODE     : String(8);
            STREET          : String(44);
            BUILDING        : String(128);
            COUNTRY         : String(44);
            ADDRESS_TYPE    : String(44);
            VAL_START_DATE  : Date;
            VAL_END_DATE    : Date;
            LATITUDE        : Decimal;
            LONGITUDE       : Decimal;
            businesspartner : Association to one businesspartner
                                  on businesspartner.ADDRESS_GUID = $self;
    }

    entity product {
        key NODE_KEY       : String(50);
            PRODUCT_ID     : String(28);
            TYPE_CODE      : String(2);
            CATEGORY       : String(32);
            DESCRIPTION    : localized String(255);
            SUPPLIER_GUID  : Association to one businesspartner;
            TAX_TARIF_CODE : Integer;
            MEASURE_UNIT   : String(2);
            WEIGHT_MEASURE : Decimal;
            WEIGHT_UNIT    : String(2);
            CURRENCY_CODE  : String(4);
            PRICE          : Decimal;
            WIDTH          : Decimal;
            DEPTH          : Decimal;
            HEIGHT         : Decimal;
            DIM_UNIT       : String(2);
    }
}

context transaction {
    entity purchaseorder : customAspect.Amount {
        key NODE_KEY         : String(50);
            PO_ID            : String(24);
            PARTNER_GUID     : Association to one master.businesspartner;
            LIFECYCLE_STATUS : String(1);
            OVERALL_STATUS   : String(1);
            Items            : Association to many poitems
                                   on Items.PARENT_KEY = $self;
    }

    entity poitems : customAspect.Amount {
        key NODE_KEY     : String(50);
            PARENT_KEY   : Association to one purchaseorder;
            PO_ITEM_POS  : Integer;
            PRODUCT_GUID : Association to master.product;
    }
}
    
@cds.persistence.exists 
@cds.persistence.calcview 
Entity BP_AD {
key     CREATEDAT: Timestamp  @title: 'CREATEDAT: CREATEDAT' ; 
        CREATEDBY: String(255)  @title: 'CREATEDBY: CREATEDBY' ; 
        MODIFIEDAT: Timestamp  @title: 'MODIFIEDAT: MODIFIEDAT' ; 
        MODIFIEDBY: String(255)  @title: 'MODIFIEDBY: MODIFIEDBY' ; 
        NODE_KEY: String(50)  @title: 'NODE_KEY: NODE_KEY' ; 
        BP_ROLE: String(2)  @title: 'BP_ROLE: BP_ROLE' ; 
        EMAIL_ADDRESS: String(105)  @title: 'EMAIL_ADDRESS: EMAIL_ADDRESS' ; 
        PHONE_NUMBER: String(32)  @title: 'PHONE_NUMBER: PHONE_NUMBER' ; 
        FAX_NUMBER: String(32)  @title: 'FAX_NUMBER: FAX_NUMBER' ; 
        WEB_ADDRESS: String(44)  @title: 'WEB_ADDRESS: WEB_ADDRESS' ; 
        ADDRESS_GUID_NODE_KEY: String(50)  @title: 'ADDRESS_GUID_NODE_KEY: ADDRESS_GUID_NODE_KEY' ; 
        BP_ID: String(16)  @title: 'BP_ID: BP_ID' ; 
        COMPANY_NAME: String(250)  @title: 'COMPANY_NAME: COMPANY_NAME' ; 
}
