#include <CppBDD/StepDefinition.hpp>
#include <CppBDD/ScenarioContext.hpp>
#include <gmock/gmock.h>

class HikerContext : public CppBDD::ScenarioContext
{
public:
	int answer;
};

GIVEN_STEP("the question")
{
	Context<HikerContext>()->answer = 6 * 9;
}

THEN_STEP("the answer is (.*)")
{
	ASSERT_EQ(Parameter<int>(0), Context<HikerContext>()->answer);
}
