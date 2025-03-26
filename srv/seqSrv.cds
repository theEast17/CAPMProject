using {india.db.master} from '../db/datamodel';

service sequenceService @(path: 'sequenceService'){
    entity sequence as projection on master.EVENTS;
}