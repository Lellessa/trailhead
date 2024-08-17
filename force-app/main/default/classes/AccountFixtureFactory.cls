public with sharing class AccountFixtureFactory extends FixtureFactory {
    
    public AccountFixtureFactory() {
        super(new Account());
    }

    public AccountFixtureFactory id(String id) {
        put('Id', id);
        return this;
    }

    public AccountFixtureFactory name(String name) {
        put('Name', name);
        return this;
    }

    public AccountFixtureFactory ownerId(Id ownerId) {
        put('OwnerId', ownerId);
        return this;
    }

}