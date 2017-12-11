defmodule Careers.DummyTest do
    use Careers.Test.Support

    test "Do: return string (Hello name)" do
        name = Faker.Name.name
        assert {:ok, message} = Exams.Dummy.hello(name)
        assert "Hello #{name}" == message
    end

    test "Do not: return string (Hello name)" do
        name = Faker.Name.name
        assert {:ok, message} = Exams.Dummy.hello(name)
        assert "Hello #{Faker.Name.name}" != message
    end
end
