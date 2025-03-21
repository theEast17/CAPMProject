using {india.db.CDSViews} from '../db/CDSViews';

service CDSViewsSrv @(path: 'CDSViewsSrv') {
    entity PODetails  as projection on CDSViews.PODetails;
    entity ItemView   as projection on CDSViews.itemView;
    entity ProductSum as projection on CDSViews.ProductSum;
}
