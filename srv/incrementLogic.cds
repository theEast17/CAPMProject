using {india.db.master} from '../db/datamodel';

service increment {
    entity worker as projection on master.worker;
    action hike(ID:UUID)
}