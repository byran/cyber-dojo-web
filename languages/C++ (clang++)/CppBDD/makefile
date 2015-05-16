# Flags passed to the C++ compiler.
CXXFLAGS += -I. -std=c++11 -Wall -Wextra -Werror
CXXFLAGS += -fsanitize=undefined -fno-sanitize-recover=undefined
CXXFLAGS += -fsanitize=address -fno-omit-frame-pointer
CXXFLAGS += -g -Wall -Wextra -std=c++11 -pthread

all : steps features

#---------------------------------------------
# Generic object file creation from .cpp files
#---------------------------------------------
%.o : %.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -MMD $< -o $@

FEATURE_PATH = features
FEATURE_FILES = $(wildcard $(FEATURE_PATH)/*.feature)

features :
	./steps --cppbdd-output=gtest *.feature

TESTS_PATH = .
TESTS_SOURCE_FILES = $(wildcard $(TESTS_PATH)/*.cpp)
TESTS_OBJECT_FILES = $(patsubst %.cpp,%.o,$(TESTS_SOURCE_FILES))

steps : $(TESTS_OBJECT_FILES)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -lCppBDDGMock -lCppBDD -lGMock -o $@

