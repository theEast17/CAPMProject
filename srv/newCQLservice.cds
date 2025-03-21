using {india.db.master} from '../db/datamodel';

service NewCQLService {
    @readonly
    entity readworker   as projection on master.worker;

    @insertonly
    entity insertworker as projection on master.worker;

    @updateonly
    entity updateworker as projection on master.worker;

    @deleteonly
    entity deleteworker as projection on master.worker;
}
