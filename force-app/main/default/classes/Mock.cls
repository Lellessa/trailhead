@IsTest
public class Mock {

    private static Integer fakeIdSerialNumber = 0;

    public static MockProvider.Answer when(String methodName) {
        return new MockProvider().when(methodName);
    }

    public static String generateFakeId(Schema.SObjectType sobjectType) {
        String fakeId = String.valueOf(fakeIdSerialNumber++);

        return sobjectType.getDescribe().getKeyPrefix() + '0'.repeat(15 - fakeId.length()) + fakeId;
    }
}