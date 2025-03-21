using {india.db.externalData} from '../db/externalApiDataModel.cds';

service ExternalApiService {
    entity ExternalApi as projection on externalData;
}
