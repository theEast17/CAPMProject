using {
    india.db.master,
    india.db.transaction,
    india.db.BP_AD
} from '../db/datamodel';

service catalogService @(path: 'CatalogService') {
    entity businesspartner as projection on master.businesspartner;

    annotate catalogService.businesspartner with @(Capabilities: {
        InsertRestrictions: {Insertable},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    entity address         as projection on master.address;

    annotate catalogService.address with @(Capabilities: {
        InsertRestrictions: {Insertable},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    entity product         as projection on master.product;

    annotate catalogService.product with @(Capabilities: {
        InsertRestrictions: {Insertable},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    entity purchaseorder   as projection on transaction.purchaseorder;

    annotate catalogService.purchaseorder with @(Capabilities: {
        InsertRestrictions: {Insertable},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    entity poitems         as projection on transaction.poitems;

    @readonly
    entity worker          as projection on master.worker;

}


@impl: './highSalary.js'
service salary {
    entity worker as projection on master.worker;
    function getHighestSalary() returns Decimal(15,2)
}

service CalViewService{
    @readonly
    entity CV_BP_AD as projection on BP_AD
}
