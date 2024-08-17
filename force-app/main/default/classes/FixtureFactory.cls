public abstract with sharing class FixtureFactory {
    
    protected SObject salesforceObject;

    public FixtureFactory ( SObject salesforceObject ) {
        this.salesforceObject = salesforceObject;
    }

    public FixtureFactory put ( String fieldName, Object value ) {
        salesforceObject.put ( fieldName, value );
        return this;
    }

    public SObject object() {
        return salesforceObject;
    }

    public SObject persist() {
        upsert salesforceObject;
        return salesforceObject;
    }
    
}