@IsTest
public class MockProvider implements StubProvider {

    private Map<String, Answer> answers = new Map<String, Answer>();
    
    public Object handleMethodCall( //NOPMD
        Object mockedObject,
        String methodName,
        Type returnType,
        List<Type> paramTypes,
        List<String> paramNames,
        List<Object> args
    ) {
        String normalizedMethodName = methodName.toLowerCase();

        if (!answers.containsKey(normalizedMethodName)) {
            throw new MockProviderException('Method not configured: ' + methodName);
        }

        return answers.get(normalizedMethodName).mockedValue;
    }

    public Answer when(String methodName) {
        Answer answer = new Answer(this);
        answers.put(methodName.toLowerCase(), answer);

        return answer;
    }

    public Object forType(Type classToMock) {
        return Test.createStub(classToMock, this);
    }

    public class Answer {
        private MockProvider mock { get; private set; }
        private Object mockedValue { get; private set; }

        public Answer(MockProvider mock) {
            this.mock = mock;
        }

        public MockProvider thenReturn(Object returnValue) {
            this.mockedValue = returnValue;

            return this.mock;
        }

        public MockProvider thenDoNothing() {
            return this.mock;
        }
    }

    public class MockProviderException extends Exception {}
}